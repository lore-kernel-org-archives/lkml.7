Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13307206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYDs3XHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfJHN7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:59:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfJHN7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570543169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFFTjSOexeHMooQarjHjyr2PYTne3A1VZs/EDwqMyEM=;
        b=aYDs3XHwVhOAWMx3tXO443kBzn7oXa56OOcnsozFe3Kh5pI9jcVixAyp59HNexT5wB2FXF
        JREOgDsglimRa1a86PFVnd5ZIXmFq5IajuykJ/+Pur6nkEimZi7DUaC9Pk0xWz2WRkZ/av
        aocyYwIaIJRXxyETPPgoFrXgoI6zyEQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-NXHJnhySOmGkuZpZveFJow-1; Tue, 08 Oct 2019 09:59:25 -0400
Received: by mail-wr1-f72.google.com with SMTP id z1so9143858wrw.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqfqD77jFR41/YTDGxujsDNqPPIibJFQFpFD/Dy6A/4=;
        b=tR8DH7yEPPeCJWVf4LcKNQPEEDFWoEBwd8eXLQB22oN7d6tQcRT0l4KIiHR/xiR2AN
         JR25Eyoz1v0AKQdBbAJ10y3T0kjnX4hjcnNPsehoRvlDTjLykgvy6RjVAE3mPgkkiNwV
         OjiDeLM+jBS773HoyVWsCEk1Ecbm9rc6Lm1yMJHx7YbPUj9HC19gaHUO4eKrCuDcotPG
         98bQQy1PILAY+OItlApDVZ0yfUS8PrjLhtJn2QnOMy2rzyN5QK1Mw8Zj+B9uY5Z+ij4i
         dxjivLUgU48jssIIT4Cv2UxUtL6YLSzvu/OQ9NrWAsUL9w0AdpfbRhM4ul7W87YK1X9F
         Qs3w==
X-Gm-Message-State: APjAAAWZohreTnSaJQsWcMwQekd/emAkeKPScQsQ0G9+XVuaTEGSOnok
        6xK43zFVEVD2nuXwi0FucQ1512rXfFd5dLsQWj03wRQ3P9k9/GmIbGRtdlrEBh/Dxm5KDiZH2or
        hA6fZPPkWHOxU62X+rOah0C3P
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr4191596wmc.113.1570543164502;
        Tue, 08 Oct 2019 06:59:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/ERWE2a7LeeUzH669s6gkhiIQR4L5acbyEE0C/SYoSNlPe3yG5pUJi6avFFO5sObnyGJbsw==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr4191579wmc.113.1570543164352;
        Tue, 08 Oct 2019 06:59:24 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id w9sm30461210wrt.62.2019.10.08.06.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:59:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
Date:   Tue, 8 Oct 2019 15:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
Content-Language: en-US
X-MC-Unique: NXHJnhySOmGkuZpZveFJow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08-10-2019 14:25, Heikki Krogerus wrote:
> Hi Hans,
>=20
> Fixed the compiler warning in this version. No other changes.
>=20
> The original cover letter:
>=20
> That AXP288 extcon driver is the last that uses build-in connection
> description. I'm replacing it with a code that finds the role mux
> software node instead.
>=20
> I'm proposing also here a little helper
> usb_role_switch_find_by_fwnode() that uses
> class_find_device_by_fwnode() to find the role switches.

Both patches look good to me and I can confirm that things still
work as they should on a CHT device with an AXP288 PMIC, so for both:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



p.s.

I guess this means we can remove the build-in connection (
device_connection_add / remove) stuff now?

