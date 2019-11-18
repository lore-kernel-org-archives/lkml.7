Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA48C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C85218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEShDiad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKRRLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:11:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41681 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKRRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:11:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id o3so21035497qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9AamA3i41CaG/YN/mH1OD14yz4M1P+YN+R1DKIQobA=;
        b=OEShDiadmaUPbbspmJ1yct3Frqqs1CgvfsGWbj9YHf7FbskUKGeOwqdbqa2/8Z3JrL
         Z2VAtNApsbPnaI7HU/0Exhb4+s/i3SZBASM17G2O7fMhdwURucIfBX+YwGcLgk9VdzdO
         5fHxgES+yWsuB8xwx9BlTpKeY6t5jQJeJajaT5zoXOpNTsMmj6F4M5lAnsk7fEa/xQi6
         OR6RIDLSFEAry9Eo/U9W6FFuojumTEjYvHu6JhigiJdKklzmaW0QgjHc5ENcLUFHk8S7
         UsnWVgLeIwJh/YufQBfOqlQ3vzFQc+xKxmRzqLeR7O9wo4EoMzuTI79k0YmT0gnRM/ks
         rVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9AamA3i41CaG/YN/mH1OD14yz4M1P+YN+R1DKIQobA=;
        b=a0ZxIHYZXdj/LEk0NBpkyrrECz/esXhUNK/L41i7ECHS+ac+08DN9ZBn3TBsJqG51T
         aiimV2sT5cWMSPTZu76ljcYQjywzNR/1VymB5XZA/GkUoMtTF1UHxWjyb5vUxi4mTxKY
         HmTpQLXtkuKDViLShzIzvi0OT5sYS9ODn9dh7GcheZ0c/WkFqh0Gob9/nNgCenuBfqZP
         pUtAxb5SR9RlazbI2FfsOx6rzcoF/JBCFPvnzqZxfE17Y6j0uKHWin/Oa21SxNhF3TfA
         iw5umTJpkq3rFMQELDSIwBEzfiZr4jm1EInAMJPAft4VxFaR/u0+61B1LIIrDX2CaCbD
         Yb2g==
X-Gm-Message-State: APjAAAWAe6X6xBOcmGWWjXTA7h2XKfigjZ1feKCwG+eMThFE3xNMy64g
        FpUubANk6XsWzdnWTh5+wMRGyHpSe7NjKxTK+azOfw==
X-Google-Smtp-Source: APXvYqyxsB78hBFrU6adUj2RffV9Rwtw2Mw6d9H6fnaWwroEef/4eio2L2UuXPksfcTtros6v7l0QWf0UDLK0UR1C70=
X-Received: by 2002:ac8:4157:: with SMTP id e23mr28174425qtm.158.1574097104300;
 Mon, 18 Nov 2019 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ee674f0597a18709@google.com>
In-Reply-To: <000000000000ee674f0597a18709@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Nov 2019 18:11:32 +0100
Message-ID: <CACT4Y+aHkU46kF26a6afuQ+UO3N3W9Ur898dFBa+mQ2q6QzoQQ@mail.gmail.com>
Subject: Re: linux-next boot error: can't ssh into the instance (3)
To:     syzbot <syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com>,
        yeyunfeng@huawei.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 5:35 PM syzbot
<syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    519ead8f Add linux-next specific files for 20191118
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14653416e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=652dd3906d691711
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce541a23cf58c1f6b1b1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ce541a23cf58c1f6b1b1@syzkaller.appspotmail.com


Looks at the console output, this seems to be related to:

commit eb09878e13013f0faee0a97562da557c4026b8a1
Author: Yunfeng Ye <yeyunfeng@huawei.com>
Date:   Thu Nov 14 15:16:24 2019 +0800

    ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100

+drivers/acpi/sysfs.c maintainers


> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ee674f0597a18709%40google.com.
