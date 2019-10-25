Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D16921D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uThP8rTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393115AbfJYFnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:43:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40672 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390519AbfJYFno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:43:44 -0400
Received: by mail-yw1-f66.google.com with SMTP id a67so392839ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=Fd7RXxRWJ4J0hJ0jyxPd09lzue/aYzfNqk8tuCDAACY=;
        b=uThP8rTzgTzB6AEaLAzCSMp87Mlw0q5biZxTlq+dxL5X9xDe15nqSSokeo7loGLgrT
         UC3cBmawByhrgGLUHkzk6epm0Kf36HDC7/6kkWz9qwxw7z0YVzqKSugWgZ4bEpZdSRrn
         ARicmfqk0dJtA4fTie+9eMHr9asJDlL3+glUv4OG2NEy7i2zoBP3LAzeBnrkIt6R8R4w
         oAH71jxt/zzOvUL/mHbmXu3BIwd3IOXD3yeBkUzIA8r1mje/oMQC5+4qZr1WZcF2O+YR
         Hi3vWncmFKSe2isMw+lFVifI8fdHupxpgRsHPddbJcvfF/rqI8RYQwMWzUwPAaK0sMtM
         +wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=Fd7RXxRWJ4J0hJ0jyxPd09lzue/aYzfNqk8tuCDAACY=;
        b=iBa2Ba4RNXUHMTCtaK/23ZtRyoxCAdJjhYG1O3bENONdJaKvJ+RDB1pHtzmCeMbm+O
         QQ5jfYMJmuAzVBpGPA+qjACgvJ49qXZa/upY7Xak6tGkSBcG5b2mh7su0ARfBGiV3dWA
         3H8/AwLXXlpofIGFN64pbQOtKwl8I4Q+G9xWFApsjd87WmkCq9nbhHme/N+9dUNty9EB
         KeFPrzVb1A3AiSYy59DkCjaG4HGdxzMy6IaFRjIsqWKjKNtmYZNPl5Ab3lIz+Hz41Nko
         Xbd5X6HlpsXxHXzrF/N16ghYPjKgBnhKLS+VuE1wLz0PP9AJZ828JozqFq1imGCPVjG/
         ZuFA==
X-Gm-Message-State: APjAAAX95MLzBK+iCuC/Cx8Q0m1sJUeIZ3gHAGQgASkpGChOgX+LrYfP
        /gu8IwxESges3KjW7qzrtAwl
X-Google-Smtp-Source: APXvYqz6j70rhPDk97kDk5M2WocFgZjOherEcRWqCGj1FuQC2lgG1k6GJ9/b7lbdUpwhgu7FyDmgFg==
X-Received: by 2002:a81:5749:: with SMTP id l70mr848949ywb.488.1571982221892;
        Thu, 24 Oct 2019 22:43:41 -0700 (PDT)
Received: from [172.31.99.25] ([212.147.57.94])
        by smtp.gmail.com with ESMTPSA id l188sm359126ywl.29.2019.10.24.22.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 22:43:40 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
Date:   Fri, 25 Oct 2019 07:43:37 +0200
Message-ID: <16e0170d878.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <7869bb43-5cb1-270a-07d1-31574595e13e@huawei.com>
References: <7869bb43-5cb1-270a-07d1-31574595e13e@huawei.com>
User-Agent: AquaMail/1.20.0-1469 (build: 102100004)
Subject: Re: [PATCH] audit: remove redundant condition check in kauditd_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2019 3:27:50 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> Warning is found by the code analysis tool:
>  "the condition 'if(ac && rc < 0)' is redundant: ac"
>
>
> The @ac variable has been checked before. It can't be a null pointer
> here, so remove the redundant condition check.
>
>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> kernel/audit.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Hello,

Thank you for the patch.  Looking quickly at it, it appears to be correct, =
unfortunately I'm not in a position to merge non-critical patches, but I ex=
pect to merge this next week.


> diff --git a/kernel/audit.c b/kernel/audit.c
> index da8dc0db5bd3..193f3a1f4425 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -830,7 +830,7 @@ static int kauditd_thread(void *dummy)
>  rc =3D kauditd_send_queue(sk, portid,
>  &audit_hold_queue, UNICAST_RETRIES,
>  NULL, kauditd_rehold_skb);
> - if (ac && rc < 0) {
> + if (rc < 0) {
>  sk =3D NULL;
>  auditd_reset(ac);
>  goto main_queue;
> @@ -840,7 +840,7 @@ static int kauditd_thread(void *dummy)
>  rc =3D kauditd_send_queue(sk, portid,
>  &audit_retry_queue, UNICAST_RETRIES,
>  NULL, kauditd_hold_skb);
> - if (ac && rc < 0) {
> + if (rc < 0) {
>  sk =3D NULL;
>  auditd_reset(ac);
>  goto main_queue;
> --
> 2.7.4.3

--
paul moore
www.paul-moore.com




