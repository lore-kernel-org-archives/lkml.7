Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B247E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="excwd9Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLMWee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:34:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41033 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMWee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:34:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so1821214plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OXnhgxzAu2ihp1gT4DqyxwZPM5Oy8xgRqpPZGSezrTM=;
        b=excwd9FkevMxcUhdTx2NzASWDsWNRvYWGjqPQf37dhH+BWvB5eXnGbvWW/yMj3d30r
         mf33Z7oEnkabTL7hfmF0jjGZddiDCUBCLOZOwSDffIJRYVdXQd2iHTp2fsbJ2bHIN3SV
         RfR62mYFSaoq9YEfTj25O4azgQgtz5cHI47KrewY5mieYT1Y9L3Mdj5BP4L6aPTq8MUx
         xUbPCNATqLq1tpS/r8R7leHxVqlYUPJX/SOayyONezzleQdziaqaQXQtnzWIjFWhhhox
         8jpkxD+67qKKZh5O//ViDzjhAK5Cg/TsDeWOvfQD6KphI+ZdfqVfCaUnxGisufiKMN5W
         767A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OXnhgxzAu2ihp1gT4DqyxwZPM5Oy8xgRqpPZGSezrTM=;
        b=d5QcobkkPkOIuqn8QAuDpIpLOVOlSmXSh15q5Ltvzr76KeYNGfTrQR/kqLTHLK5bY+
         6Dgvq/V6MEPLNp/MFpJyI0v8JGKvjyDnTJj8lTIM39N+dz0xg9U8B1X+t2mXIVBHgywH
         EUDnCIoZL8A899gUTxfwNoAWrJ8v/Z/xh7TaNkPP4a71EpRkzIqd3xWA86MLSQzBWvKO
         Jagf8/hQamJIkZ9sZDfXJGUfpRxjLTmk3Vipn7vdyZe4y1Zmnbl7Trnndy3SqdGG73IO
         wfg5dY7r3lYl3sfPXGBr3TB3Fg1DBOqjxGXcy4dsjdYLo0QZY1lfhCQ81j2h/R1Tykgz
         qt3g==
X-Gm-Message-State: APjAAAUraFvoFBEZ3VdhKGE6zwQbyCN+VOEyYfV3CyTMqPNCyPu07ETD
        t6eIO/cHIa1P5A8D3JkCUJdjPw==
X-Google-Smtp-Source: APXvYqyrfBN+RCPQBKIztlW8mo/Olwfn7pXA1oT//M3eThgBJmFAPX3aFrnLGHKEFff4HXyHJdc10Q==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr1974551plp.192.1576276473417;
        Fri, 13 Dec 2019 14:34:33 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x4sm12578994pfx.68.2019.12.13.14.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 14:34:32 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: meson: clock updates
In-Reply-To: <1j8snhbl4t.fsf@starbuckisacylon.baylibre.com>
References: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com> <1j8snhbl4t.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 13 Dec 2019 14:34:32 -0800
Message-ID: <7heex797nr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sun 08 Dec 2019 at 19:05, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
>> This series moves the XTAL clock out of the main (HHI) clock controller
>> because it's an actual dedicated crystal on the PCBs.
>>
>> The last two patches add the DDR clock controller whose output is used
>> as input for some of the audio clocks.
>>
>>
>> Dependencies:
>> - patch #1 has a runtime dependency on my other series:
>>   "provide the XTAL clock via OF on Meson8/8b/8m2" [0]
>>   Jerome has already queued this for v5.6
>> - patches #2 and #3 have a compile time dependency on my other series:
>>   "add the DDR clock controller on Meson8 and Meson8b" [1]
>>   Jerome has already queued this for v5.6, but you need an immutable
>>   tag for the dt-bindings
>
> Bindings tag clk-meson-dt-v5.6-1 available with the necessary ids
> branch v5.6/drivers with the actual driver changes

Queued for v5.6,

Kevin
