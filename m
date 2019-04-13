Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D35DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3682147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="apkK/yEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfDMSkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 14:40:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43310 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDMSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 14:40:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so929837edq.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpQy5EGBsBRgMuLmzYbInUtkXiyNN4F2qnaTMESb2Yc=;
        b=apkK/yEJlKuiAHlAl/S4L82e8UY04yonV9+T3bTPpnEeHo1fgWg2bpLXMSOjNcplVg
         olozreovQlxf3kQi2mxgW++T0cWkUsmlzUSRZiGb1BK2o6mBECtgs4kFQQej4GXvxRC9
         qZvGLttTUehpNq+SIzwAAfuPe8cG7hDAjRbSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpQy5EGBsBRgMuLmzYbInUtkXiyNN4F2qnaTMESb2Yc=;
        b=VvM7BM9CUjhMB4/KkWVLwJSmLtCMVjZpSh5Vgzl05aInInWcDwsNMDTm4lbx3PvKgo
         BNFha5MOjYtBAIH3K7UBsQp/0lZz/YWoLjz1kBmeNxUGJKcXOBo5+vuAR5lOSOCtR+hg
         XsHAan6fOCgCNavDyq4eF2YWLmSFFvfpB6IqfYUyZBcFEix5BvvVe64TGFbw5IGLTC9B
         amXA3nNixTov1DNYbvY9WvXH9RPi8etBuym4plzaq02DNxWOlJkhTXW8kLm6IIAhhUIm
         R1h0aOoVjHlOYDmL4pUGc/uAOaKevA0BFcDNM+9jWVKuF5LUgAINoQmefYVBnxwmuqnX
         NSCg==
X-Gm-Message-State: APjAAAXFTy5hCiKPqP5Es3+UF6k5ul86dgMyuXxVsHy2nH+D+8LY4fSk
        4IEg45JMd6f2X6iZkkS5rehxlrfXVlliojQunHPUMw==
X-Google-Smtp-Source: APXvYqwjKquuCxN+QxhyRX+gE8EdEXlrDRyjMruL5pbB0MhYVYvtdqTjzEzEnzsZamNGjsr4KV7MygTXzocx3eCxJn4=
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr34703482ejj.117.1555180847128;
 Sat, 13 Apr 2019 11:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <1555149112-14115-1-git-send-email-jiaolitao@raisecom.com>
In-Reply-To: <1555149112-14115-1-git-send-email-jiaolitao@raisecom.com>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Sat, 13 Apr 2019 11:40:36 -0700
Message-ID: <CAJieiUjAhzwTeYD5DWHM0wUdp7bKhZm_CZ6Rg1R5Ykht6jAD5Q@mail.gmail.com>
Subject: Re: [PATCH] vxlan: do not add dynamic fdb entry when the dev has been downed
To:     Litao Jiao <jiaolitao@raisecom.com>
Cc:     David Miller <davem@davemloft.net>,
        Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 2:52 AM Litao Jiao <jiaolitao@raisecom.com> wrote:
>
> When the dev has been downed or goes downing, it should not
> add dynamic fdb entry for the dev.
>
> Signed-off-by: Litao Jiao <jiaolitao@raisecom.com>
> ---

This will break existing users. netif_running check is already there
for dynamically learnt entries.
Why do you need it here ?. none of the ndo_fdb_add handlers check for
link state.


>  drivers/net/vxlan.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
> index d76dfed..3b45fe4 100644
> --- a/drivers/net/vxlan.c
> +++ b/drivers/net/vxlan.c
> @@ -1125,11 +1125,13 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>         if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
>                 return -EAFNOSUPPORT;
>
> +       err = -EINVAL;
>         spin_lock_bh(&vxlan->hash_lock);
> -       err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
> -                              port, src_vni, vni, ifindex,
> -                              ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
> -                              true, extack);
> +       if (netif_running(dev) || (ndm->ndm_state & NUD_PERMANENT))
> +               err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
> +                                      port, src_vni, vni, ifindex,
> +                                      ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
> +                                      true, extack);
>         spin_unlock_bh(&vxlan->hash_lock);
>
>         return err;
> --
> 1.9.1
>
>
>
