Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C89C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A7921773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f7DFyXKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfEWQic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:38:32 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46313 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfEWQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:38:31 -0400
Received: by mail-ua1-f66.google.com with SMTP id a95so2398220uaa.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0rDpYcpEU2DlpfJPWclkw5oXzfo0RvY7oAeAA+3T90=;
        b=f7DFyXKTBWt5U7XgFYEc6tpBvygZbJf11fOqOQXgOXkwOVzXyJkqrEFj1jL04GFqyF
         KaPeTgWPv1xcwPktqe+PKBE5ipEuuUyahM+6zRAjX7mwCrDn8SQiMqpgRr8v4QSo8uBt
         mai/Br9ocyY4z1h4P4lZ9JoH9BK9pnb/uS9X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0rDpYcpEU2DlpfJPWclkw5oXzfo0RvY7oAeAA+3T90=;
        b=DW/iAnxn8I8kPt2KCBOZMwuLO5O3p8Kdw9wpYUdKLmk6O9bErhTIjz2Grq+MGEvP4u
         MlngadFaMv2nGQ6wAJ6HzyGXenU34ycxAhsyuaShvGHBoLuo2bu3MdCnk7mt/S2Bn7Ck
         I6dmV9xYRgGVw6d9kYlJQh40Da9S3R8eYxOLQD/3bZGBJhUG2UZjQj00q1NvXiSD6BVi
         dPDyOmEUpjPByo4Yxqg92gSEsdcdijq1SrBGXwck3kml/83SLU5XSGCeG26xL6vdX8fw
         6bHkMl2+/qhghUucdEtdwrFx115REkh4BuBRoq1m7p2HUHSqpijx5Er7Ru3IjCbb+kdJ
         shkg==
X-Gm-Message-State: APjAAAVzqHboTTCwpWirh5qty3/si/LSIIE6nVJk1Kvzoy4jDKciFqXG
        m0weoOK27JOJieV/PSZ+cR/3N3Yw5Yg=
X-Google-Smtp-Source: APXvYqwwv2GeXYd2l4kWC+IbjJkN/SM5JR+83UAD/cPNsfmK6f8VN34PEmpZZ94xsMDK4XzlTTBiWA==
X-Received: by 2002:a9f:22e8:: with SMTP id 95mr41344595uan.6.1558629509570;
        Thu, 23 May 2019 09:38:29 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id w9sm6046890vkh.53.2019.05.23.09.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:38:28 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id l20so3990844vsp.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:38:25 -0700 (PDT)
X-Received: by 2002:a67:1cc2:: with SMTP id c185mr23275103vsc.20.1558629505309;
 Thu, 23 May 2019 09:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190501043734.26706-1-bjorn.andersson@linaro.org> <20190501043734.26706-3-bjorn.andersson@linaro.org>
In-Reply-To: <20190501043734.26706-3-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 May 2019 09:38:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVxKSp6e=j8YM8JBrhsF+T=0=8xDjd_817hphOMWHVFA@mail.gmail.com>
Message-ID: <CAD=FV=VVxKSp6e=j8YM8JBrhsF+T=0=8xDjd_817hphOMWHVFA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] soc: qcom: Add AOSS QMP driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 30, 2019 at 9:38 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> +static int qmp_qdss_clk_prepare(struct clk_hw *hw)
> +{
> +       struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
> +       char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 1}";

nit: "static const" the buf?  No need to copy it to the stack each
time.  In qmp_qdss_clk_unprepare() too.

...your string is also now fixed at 34 bytes big (including the '\0').
Do we still need to send exactly 96 bytes, or can we dumb this down to
36?  We'll get a compile error if we overflow, right?  If this truly
needs to be exactly 96 bytes maybe qmp_send()'s error checks should
check for things being exactly 96 bytes instead of checking for > and
% 4.


> +static int qmp_qdss_clk_add(struct qmp *qmp)
> +{
> +       struct clk_init_data qdss_init = {
> +               .ops = &qmp_qdss_clk_ops,
> +               .name = "qdss",
> +       };

Can't qdss_init be "static const"?  That had the advantage of not
needing to construct it on the stack and also of it having a longer
lifetime.  It looks like clk_register() stores the "hw" pointer in its
structure and the "hw" structure will have a pointer here.  While I
can believe that it never looks at it again, it's nice if that pointer
doesn't point somewhere on an old stack.

I suppose we could go the other way and try to mark more stuff in this
module as __init and __initdata, but even then at least the pointer
won't be onto a stack.  ;-)


> +       int ret;
> +
> +       qmp->qdss_clk.init = &qdss_init;
> +       ret = clk_hw_register(qmp->dev, &qmp->qdss_clk);
> +       if (ret < 0) {
> +               dev_err(qmp->dev, "failed to register qdss clock\n");
> +               return ret;
> +       }
> +
> +       return of_clk_add_hw_provider(qmp->dev->of_node, of_clk_hw_simple_get,
> +                                     &qmp->qdss_clk);

devm_clk_hw_register() and devm_of_clk_add_hw_provider()?  If you're
worried about ordering you could always throw in
devm_add_action_or_reset() to handle the qmp_pd_remove(), qmp_close()
and mbox_free_channel().

...with that you could fully get rid of qmp_remove() and also your
setting of drvdata.


> +static void qmp_pd_remove(struct qmp *qmp)
> +{
> +       struct genpd_onecell_data *data = &qmp->pd_data;
> +       struct device *dev = qmp->dev;
> +       int i;
> +
> +       of_genpd_del_provider(dev->of_node);
> +
> +       for (i = 0; i < data->num_domains; i++)
> +               pm_genpd_remove(data->domains[i]);

Still feels like the above loop would be better as:
  for (i = data->num_domains - 1; i >= 0; i--)


(BTW: any way you could add me to the CC list for future patches so I
notice them earlier?)

-Doug
