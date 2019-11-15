Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FB2206D6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATy8lieE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKOXkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:40:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41554 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfKOXkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:40:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so5713720plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=+XDMDwtLZbF6RVlSCLkQwNjqRZYVVLh4tuHqqX3hF8k=;
        b=ATy8lieENSWkqw31dbniYF5chS9Ym+ri46pF2L2cPudIPAXD/K+eooeSBtUNldl5th
         TE+/gN5y4OpCd/AKQvI3Pjnh/uJX1ZRd8n7zFSrcgF+Us24LoATpFWNf2ukbR0gfewTU
         HHq79yGE8Lf0ZLO9uG7oEk3pO3besCb571IsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=+XDMDwtLZbF6RVlSCLkQwNjqRZYVVLh4tuHqqX3hF8k=;
        b=cYHk+7dM63n+zzU6RA0QLYv0My9R2NRl1j3aDFthulmOXIsanxuTQ+ACmTIjoz5DQx
         j9pbWlo7kRzAjM6t+bfFZOWDQaHGP22gQLhxtFTcmgFKtwksxZbc80QDtN5MlC5XJ7ib
         SUAzHK81M93gNbw1COdVVl1oCvPLqBD+y6OKpoHm57jM7awJWQU/9f2MtfS/OpxDFV9l
         dTrz4SaBQ8DsBQAm62M4X62vhGnxpAVpnMf3Mi0j9wbOeo+1AYLW/DaEOTKCDxVePU6v
         gIZVRu4hke3CtZYbC87WuS8uKXeFpZzpQIqTW807UecmhmQLMSRG36Wm3ZM0aOVzcjxR
         TRvg==
X-Gm-Message-State: APjAAAW88Vocj0ZcsSTMrIrKDgNs5Q4grAFmTq2GJebKIoQqsKKMJ4jC
        GOygz2Tx5tgQuNyzA2CAuefKFw==
X-Google-Smtp-Source: APXvYqwn1638XPWFmd6YFWaYv6V9xuStQxxnhD+ycGHaJb4RleXlcXVY6Isx3yZhz9MsGaJwE/X0Yw==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr17276746plt.185.1573861231936;
        Fri, 15 Nov 2019 15:40:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c12sm12027324pfp.178.2019.11.15.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 15:40:31 -0800 (PST)
Message-ID: <5dcf376f.1c69fb81.6fa51.4fa7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-7-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-7-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 06/18] firmware: qcom_scm-64: Move svc/cmd/owner into qcom_scm_desc
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 15:40:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:42)
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-6=
4.c
> index 7de6022..e81fb6e 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -46,8 +46,11 @@ enum qcom_scm_arg_types {
>   * @res:       The values returned by the secure syscall
>   */
>  struct qcom_scm_desc {
> +       u32 svc;
> +       u32 cmd;
>         u32 arginfo;
>         u64 args[MAX_QCOM_SCM_ARGS];
> +       u32 owner;

Owner is always the same. Why move it to the qcom_scm_desc structure? I
can understand svc and cmd but there's no justification for this struct
member.

>  };
> =20
>  static u64 qcom_smccc_convention =3D -1;
[...]
> @@ -542,26 +584,32 @@ int __qcom_scm_io_readl(struct device *dev, phys_ad=
dr_t addr,
> =20
>  int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned =
int val)
>  {
> -       struct qcom_scm_desc desc =3D {0};
> +       struct qcom_scm_desc desc =3D {
> +               .svc =3D QCOM_SCM_SVC_IO,
> +               .cmd =3D QCOM_SCM_IO_WRITE,
> +               .owner =3D ARM_SMCCC_OWNER_SIP,
> +       };
>         struct arm_smccc_res res;
> =20
>         desc.args[0] =3D addr;
>         desc.args[1] =3D val;
>         desc.arginfo =3D QCOM_SCM_ARGS(2);

The style is weird here. Half of the struct is initialized during
declaration and the arguments are set here with individual statements.
Can we have one way or the other and not both?

> =20
> -       return qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
> -                            &desc, &res);
> +       return qcom_scm_call(dev, &desc, &res);
>  }
> =20
