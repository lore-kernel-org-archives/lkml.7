Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22156C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BE1218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oAhMeVMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391738AbfGWTsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:48:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36284 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGWTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:48:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so45321072oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3y2Rp7SMI3XNaqXS79DCDXZRuJ6DjUasigpS5O8UtzA=;
        b=oAhMeVMIqxcslXOZp+fN01DYk7ZSL+gRIe91aqObFv1d0shZNBp7uGvSNjhf93u4K4
         nhHo47WlvlFMwl49hCFcLmr3kXP6VdNeNoOTfbxPS7oFs1Ym4Nwz5foL7NX1bQyZPPLS
         ZONFhen8K/symnRpQCMk1pOaxhQipkn1QtGp9q5alww8mNRwv7MRMDzwbK7MJ8bCsgRe
         UHl3JlirEe0ktiJxe/6KGZlaDkB1nc4lodOFWB2WVZRPdfvgQrgTJ7s+a6nOiyKTmefb
         NK7FAob1/ThIiM+GobuZB4q9l/7qmyFBSUyY56TsgtYs1OnDl7OUN4jUrb2lYnXiaIel
         HbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3y2Rp7SMI3XNaqXS79DCDXZRuJ6DjUasigpS5O8UtzA=;
        b=CLr8FXx47fPCVvzdA/69hZUUUiv51aCE3c3mE+FQqyQ1UnDd06xLdKcdxKpVT8NiR5
         pkOKPjYJjkxXRJoUqYE+vsfhSGDXs1S1M/bTUQPL7BP+lcpj/K+TWEU6ScrPxjpsBxVn
         zJ9kAilgZP3mE4Fs2PQ6BHn/XLSP5lWoNEdN3aHrK0e2iGo6WPnAuG9g6Nel6pcd4/Wa
         lhFSj9z0iBPcT2NgF7fB1PGvggr3liWvZ4DROVzdRQC6YFd02FP+r7N4ILphWcxD0MVm
         Cz7T+MP26Kv5G9UWm/fbQKZJhectUHNBm9E+ytHVKqLm9Jr4NT1UvdNZBd+RpihQRwVL
         K9iQ==
X-Gm-Message-State: APjAAAXVjIaWEreR55tmOwkMUPgniC88G61bRMqwpuvuy/I/hv+Xt6DE
        IyFLgJmtsCCEjI7OMWi64hO4Lh/JkHGjaZtYIew=
X-Google-Smtp-Source: APXvYqw/uKPTduoxeheqy1d3LXpDotwVX18KQYuRpL6MWLDg3MwWHQz/jKriVKqFVvSKsjH4LkYRoVJs7LfrUSTwnKU=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr57217603otb.98.1563911325066;
 Tue, 23 Jul 2019 12:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190719192954.26481-1-xruppen@gmail.com>
In-Reply-To: <20190719192954.26481-1-xruppen@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 23 Jul 2019 21:48:33 +0200
Message-ID: <CAFBinCDRHbsDPe58qCfOzM_mZ+tmZpg2=dbfWcHntCn4xajOdw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: odroid-n2: keep SD card regulator
 always on
To:     Xavier Ruppen <xruppen@gmail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 9:29 PM Xavier Ruppen <xruppen@gmail.com> wrote:
>
> When powering off the Odroid N2, the tflash_vdd regulator is
> automatically turned off by the kernel. This is a problem
> when issuing the "reboot" command while using an SD card.
> The boot ROM does not power this regulator back on, blocking
> the reboot process at the boot ROM stage, preventing the
> SD card from being detected.
>
> Adding the "regulator-always-on" property fixes the problem.
>
> Signed-off-by: Xavier Ruppen <xruppen@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>
> Here is what the boot ROM output looks like without this patch:
>
>     [root@alarm ~]# reboot
>     [...]
>     [   24.275860] shutdown[1]: All loop devices detached.
>     [   24.278864] shutdown[1]: Detaching DM devices.
>     [   24.287105] kvm: exiting hardware virtualization
>     [   24.318776] reboot: Restarting system
>     bl31 reboot reason: 0xd
>     bl31 reboot reason: 0x0
>     system cmd  1.
>     G12B:BL:6e7c85:7898ac;FEAT:E0F83180:2000;POC:F;RCY:0;
>     EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;EMMC:800;
>     NAND:81;SD?:0;SD:400;USB:8;LOOP:2;EMMC:800;NAND:81;
>     SD?:0;SD:400;USB:8;LOOP:3; [...]
>
> Other people can be seen having this problem on the odroid
> forum [1].
thank you for submitting this patch (and not keeping it to yourself)!

> The cause of the problem was found by Martin Blumenstingl
> on #linux-amlogic. We may want to add his Suggested-by tag
> if he agrees.
yes, if you re-send this patch to address Neil's comment then feel
free to add my Reviewed-by as well as a Suggested-by


Martin
