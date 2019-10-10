Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA030C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE91A20679
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlkVTD+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbfJJIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:55:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39262 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389866AbfJJItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:49:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so4183338otr.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i7x+K8651hgIy7vdDR6Zt9vaI1+cn8lMNER3MAuYquo=;
        b=TlkVTD+JCHYjVma9N9uOQVzkuJtq3UwH8lC4lTKvIVObRyHZf0BPj0R7YBra94ylN/
         Wbn5bj62YxmwjafOfDfheKwHb6LvHHYweRsIw6MFRRlZHLAZwZ7osB516rUvWTSJTx0t
         ar25YnuklUntiHMnpYY2fXy0yh5/FHRL8p3NnzKT9LicUZJJeAeZ3Yt3ox5Qf7wDjPzM
         Hq+DM8zw5qlwzxFiBnQ8X8iQV0iEb5tdO34zlI4Nfo0OdXk4qF32Q+W7d1o+HqiuxHQ2
         8hIbgfBH1dEwDAYCZey/qsu2cjJwzYwZAYxgri6b337Pvb0jnFPqibEldgfsaTU1WdOi
         GPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7x+K8651hgIy7vdDR6Zt9vaI1+cn8lMNER3MAuYquo=;
        b=A1S1mEaTcBm+FmhaDtvWnscTlfaF8bBHRiMQJWNhyN7u8mGhh+rVnOx92ydvvtE0s8
         fD1CafPpZvLyjWQINhtjvFcSbSN0Wrm0BDbrHOlOIQ0pYpXjjK+sc/prVPjo09XK74qu
         bWhpGjT2gj5sb0I3BKUkaar9eMrVmQ8D6iWGxnTqGaW/9AWa7UxEa7QZMNVGmxjyG6Rj
         twYEfLWG05N8bsz+PWBY/GhHJ7DpjKSA1XzeDrvlFDHMnz1ZNmDaNBuZEzEz6AzUos7H
         u5aP017TQazwfaLHOdSis6mN6JEjqejH7ZmXQwmjQT19r7UA518zntZUEwlB0zie7iw9
         MiIg==
X-Gm-Message-State: APjAAAUTMyU0iOyHDu/BtwuQ9KpMo7iicjUWRSt9Ik8usA3BccYgCT11
        IyZ9VbkHIMwmkjNxjFL5uXiFboRP
X-Google-Smtp-Source: APXvYqx/cHyIkHYEAAAAmvOGl+7j4ZuK0hT4Sy+qyofWNfdZbTsihM31PLMqUr02erb/c8qr/FOMVw==
X-Received: by 2002:a05:6830:11cc:: with SMTP id v12mr6648565otq.362.1570697391409;
        Thu, 10 Oct 2019 01:49:51 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.4])
        by smtp.gmail.com with ESMTPSA id y8sm1515066oig.55.2019.10.10.01.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 01:49:51 -0700 (PDT)
Subject: Re: (RESEND) [PATCH] ocfs2: Fix error handling in ocfs2_setattr()
To:     Chengguang Xu <cgxu519@mykernel.net>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com
References: <20191010082349.1134-1-cgxu519@mykernel.net>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <6c6a49dd-f1e6-da3e-8481-071071c91b06@gmail.com>
Date:   Thu, 10 Oct 2019 16:49:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010082349.1134-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/10 16:23, Chengguang Xu wrote:
> Should set transfer_to[USRQUOTA/GRPQUOTA] to NULL
> on error case before jump to do dqput().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Looks good.

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 2e982db3e1ae..53939bf9d7d2 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1230,6 +1230,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
>  			transfer_to[USRQUOTA] = dqget(sb, make_kqid_uid(attr->ia_uid));
>  			if (IS_ERR(transfer_to[USRQUOTA])) {
>  				status = PTR_ERR(transfer_to[USRQUOTA]);
> +				transfer_to[USRQUOTA] = NULL;
>  				goto bail_unlock;
>  			}
>  		}
> @@ -1239,6 +1240,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
>  			transfer_to[GRPQUOTA] = dqget(sb, make_kqid_gid(attr->ia_gid));
>  			if (IS_ERR(transfer_to[GRPQUOTA])) {
>  				status = PTR_ERR(transfer_to[GRPQUOTA]);
> +				transfer_to[GRPQUOTA] = NULL;
>  				goto bail_unlock;
>  			}
>  		}
> 
