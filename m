Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7D520863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fh557pb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfEWRS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:18:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38006 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfEWRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:18:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so3476345pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YloeaLv8j/8CdU/rR2e95VLQQZQwEkYX+NzJuaPndDk=;
        b=fh557pb9rJEzVtAf7S1A0gQ3SQrSKOPSNOy0iJ9MplvDyGbbcUToSF3oH3aszBWnGv
         AEMEqWvT/GY43YQxI54XOwjq/8R97X8gM1DQUqV6IhdaQLXX4w42VJseNaeNpnFt24mA
         Iu3m8zZvxZBPO0ZpsvSUpXU6EAiWC/iETra1JV/QYZ0zw7FERrt+WNAXKgc4sJbvxqFh
         aDnHVh6wKGCQS04MwZpaAYaVNxC3BW5BDrlbScTfY3IC8DR3kAg7UmwCuB/FNepIlwzA
         cgMQRhStbURFadohc8tJuhMWBrbjTurlRm8zW9/Z8jgLkQUhobpUP2K1EqR1W1GpCVh/
         VR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YloeaLv8j/8CdU/rR2e95VLQQZQwEkYX+NzJuaPndDk=;
        b=t5Bmuv28bphKMgl7lUQUTcvUFOM8RPMBJHY57hxiL9g1InkPxVE+vhIRXdYqlZvDQh
         +/+P+CZsy/rZmAjRhbA3gWZKkxxoWsm2XHEPqeRtj4mnUV1VU8MZZBibFURc/GyQvBQF
         iCNqnUguWYtI8wOHk83rOwENwm+dMKvi1TbzABuv4F5ni82+ImjAqxkOU166bjuTsbmd
         EDoec7S6YKQrcNEaXBairNg44kj8cfzphiHXigkfoX4SrE9D72fPoXYXrkY4URV7rVa7
         mTEXEJd/VTc7QIs8L4VnaPbXjMRG+cNe2+64OL/jLUs+uN0lQIusTk5ALntKSlB7FpEa
         F+jA==
X-Gm-Message-State: APjAAAXZzyLq9aNdi8mnAiMHN8y/yLAG81m1Dvk0A+JGhNRUL4cxDQms
        II8p65gYuKKc3YBd+zm4bXVGCw==
X-Google-Smtp-Source: APXvYqxm1N4Ih/eqOYx9sg3AgTVOm37fzlGSbcyqTWEcKx6HGuceV5W9E6JFu+pn5r2gZ6BszP2VNA==
X-Received: by 2002:a63:234c:: with SMTP id u12mr101562576pgm.264.1558631904843;
        Thu, 23 May 2019 10:18:24 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id t7sm33669908pfh.156.2019.05.23.10.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 10:18:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>, Andrew Lunn <andrew@lunn.ch>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH v2 3/5] arm64: dts: meson: g12a: add mdio multiplexer
In-Reply-To: <97cde329c44eade402deb517211a15fd70103f01.camel@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com> <20190520131401.11804-4-jbrunet@baylibre.com> <CAFBinCA_XE86eqCMpEFc3xMZDH8J7wVQPRj7bFZyqDxQx-w-qw@mail.gmail.com> <20190520190533.GF22024@lunn.ch> <97cde329c44eade402deb517211a15fd70103f01.camel@baylibre.com>
Date:   Thu, 23 May 2019 10:18:23 -0700
Message-ID: <7h4l5l3x9c.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Mon, 2019-05-20 at 21:05 +0200, Andrew Lunn wrote:
>> > > +                               int_mdio: mdio@1 {
>> > > +                                       reg = <1>;
>> > > +                                       #address-cells = <1>;
>> > > +                                       #size-cells = <0>;
>> > > +
>> > > +                                       internal_ephy: ethernet_phy@8 {
>> > > +                                               compatible = "ethernet-phy-id0180.3301",
>> > > +                                                            "ethernet-phy-ieee802.3-c22";
>> > Based on your comment on v1 of this patch [0] the Ethernet PHY ID is
>> > defined by this "mdio-multiplexer" (write arbitrary value to a
>> > register then that's the PHY ID which will show up on the bus)
>> > I'm fine with explicitly listing the ID which the PHY driver binds to
>> > because I don't know a better way.
>
> ... 
>
>> 
>> Does reading the ID registers give the correct ID, once you have poked
>> registers in the mdio-multiplexer? If so, you don't need this
>> compatible string.
>
> Hi Andrew,
>
> In 5.1 the mdio-mux set a wrong simply because I got it wrong. I pushed a
> fix for that, and maybe it has already hit mainline.
>
> As I pointed to Martin on v1, this situation just shows that this setting is
> weaker than the usual phy setup.
>
> I do understand why we don't want to put the PHY id in DT. If the PHY fitted on
> the board changes, we want to pick it up. This particular phy is embedded in
> SoC, we know it won't change for this SoC, whatever the mdio-mux sets.
>
> So yes it should (soon) work as usual, setting this id is not strictly
> necessary but it nicely reflect that this particular phy is integrated in
> the SoC and we know which driver to use. 
>
> So, if this is ok with you, I'd prefer to keep this particular id around.

Seems OK to me, so I'm queuing this for v5.3 because we really need
network support.  It can be removed later if it's really insisted on.

>> 
>> If the read is giving the wrong ID, then yes, you do want this. But
>> then please add a comment in the DT blob. This is very unusual, so
>> should have some explanation why it is needed.
>
> Sure, can add a comment. I suggest to do it in follow-up. At least it keeps
> things aligned between the gxl, which has been like this for quite a while now,
> and g12a.

Follow-up is good for me,

Kevin
