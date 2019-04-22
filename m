Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC97C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198C420881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1Vsd5mi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfDVPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:32:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40906 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:32:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so10641146ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E04feIBZvZgiVWqwgFV5BaACVYyGdJMCpkpJ4kHAwQY=;
        b=1Vsd5mi/YJTV9ZRCuC03jJyZGvAuIlKF6gnlH0Z1xoWogH2lYJGWIw56UP1mqxEOts
         V2gFjPoOUGC3BYD+TPBFKt+HE0NkBGagMhWOk5ujwVSNmmNrR6e3tvBL12wHYuQ9IiL1
         z+09RRonafiWrJaEk/EvvOT/wXXD0uoDSdBIfULzbVNL+f9zB8+KK7qDniY1AssCwBhk
         XpRl3DvCckhurWFPhH5kZnhWVTxLglwAeFFQnk35+3h5tyhdNBV5VNvqI98NkvZwdrsV
         zJB/cvMv22ZN7Veg+2GvnOD4i5+GxMGpDuxG+I5fyNFsKijIifI0A2w4Z1rOPbBgeOpG
         gOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E04feIBZvZgiVWqwgFV5BaACVYyGdJMCpkpJ4kHAwQY=;
        b=UDdDY2JouGdCCoIArB58fEiVatR61Hhn5x530zpgT2tYrVJTHKjYzWjxVCep0F9/Ot
         cWSAI5teTqCjTYDeqrkg7tZ8JeIazHVIAbQM1Q5MtfOWjFrv2djPJ/tlrRFVS7jc/wOL
         5bz4zv2EtJ1t4bUZFOGJcb3onfVZEzgxXqw9Od05iqbWmcQP1NjENaq4kkv59WVNPBe4
         NEUvF6gARABOshH1ah0sN3zlri7qckFPr64zUDARHVqSN7oTqJHfJCEOUsVu8r9t53um
         dMNQnbnLL5E2zoxcf1iniQvukOAzbATMehlsfDq9d4XNuKqhEJYVj6cPKgKhcTl1dXyz
         CQ9w==
X-Gm-Message-State: APjAAAW97Htw1UBpjpYvdSEPu9RGylS2oCP8ob1Lgp1N1S91kByockUJ
        H5AzcFxFejKAvgz46tNmTps9bHsBVb1fEGaG8zyh
X-Google-Smtp-Source: APXvYqxm4QvCJjkdKj/9cXI5AYMznijDBv2jwQmA6fBtM4LC3GKLYwn+JHXpsw7wqCM4Smg7nczBsNU7+3Y13R7zZw4=
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr10619599ljg.161.1555947175731;
 Mon, 22 Apr 2019 08:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <1555724969-15300-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1555724969-15300-1-git-send-email-wang6495@umn.edu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Apr 2019 11:32:44 -0400
Message-ID: <CAHC9VhTu4dmCaivFw5zv-znx-KyhJadW21WVdgss5Aw5BEpcsw@mail.gmail.com>
Subject: Re: [PATCH v3] audit: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 9:49 PM Wenwen Wang <wang6495@umn.edu> wrote:
> In audit_rule_change(), audit_data_to_entry() is firstly invoked to
> translate the payload data to the kernel's rule representation. In
> audit_data_to_entry(), depending on the audit field type, an audit tree may
> be created in audit_make_tree(), which eventually invokes kmalloc() to
> allocate the tree.  Since this tree is a temporary tree, it will be then
> freed in the following execution, e.g., audit_add_rule() if the message
> type is AUDIT_ADD_RULE or audit_del_rule() if the message type is
> AUDIT_DEL_RULE. However, if the message type is neither AUDIT_ADD_RULE nor
> AUDIT_DEL_RULE, i.e., the default case of the switch statement, this
> temporary tree is not freed.
>
> To fix this issue, only allocate the tree when the type is AUDIT_ADD_RULE
> or AUDIT_DEL_RULE.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/auditfilter.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Merged into audit/next - thanks!

-- 
paul moore
www.paul-moore.com
