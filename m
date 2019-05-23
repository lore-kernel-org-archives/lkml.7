Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D3DC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAC20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmZfodkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfEWSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:05:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42608 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731217AbfEWSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:05:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so3047691plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=6pE6kWKLMNmCAMtPKUOMVO4s8yEu+hqlcvsuOOg16Yg=;
        b=kmZfodkwj6bZG7b3e8M5lAMf6j/Emh+52RL0DK5E7X56QD5/fAcEXbOc7ha00H6GBw
         LYTSXodR7fhho/tgzc7Z5Lybb/5ZIuzlJdyrT1rF4G6gg8mjTj+n2x5qxZOuI/XQx+fD
         Q0XrCpXSboO2bsh7qDWbsnXfsXgH7KJhfVdzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=6pE6kWKLMNmCAMtPKUOMVO4s8yEu+hqlcvsuOOg16Yg=;
        b=b7XxmKpnKw9yfL9t61Cwdrn8j41KZIi2p7fMWcnY3VPrSaRXuvmDLPCG2HFOVpW7BY
         cP/NVe89eHxmTVrxMNnjEVlR27RLn9KRG5WCK5FxK9OeuWtDJZ4WCTUtn2bMykSpVe1u
         R8AVtDLLrpG576xPgr6NHYeRZqUqXLVzFhV1tXo7Smju7yre7X8ytjz8oAoDrvpqQrQN
         ALQnf+aGbOUv9KHys1c7wOKrmqm3v2txk4gOL6MaOpouN8LOA2CYxcdEi+lTda//Sj4K
         0az3g2JGMQk1Zo9VpGsD+Y7U9p6W1qEcIfdphmzNAAAKmOK/JWQISSUCJiGWgdSFmdqR
         pogQ==
X-Gm-Message-State: APjAAAUhNu9C4bUyS/27RjG31HsD2g3Dkvy8z7B69k4R4t31JsA+cKpw
        PVkXg6KuXU4kZJ+KLP9abplV3w==
X-Google-Smtp-Source: APXvYqz59jHYdmyOQnuk3n1IYDdWW3SY+/oJmtXkWN3L9jer4VKjVzx9nW+3mkcRp8iYvw7CDOy+ew==
X-Received: by 2002:a17:902:2e81:: with SMTP id r1mr84043412plb.0.1558634702161;
        Thu, 23 May 2019 11:05:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z9sm46636pgs.28.2019.05.23.11.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 11:05:01 -0700 (PDT)
Message-ID: <5ce6e0cd.1c69fb81.9a03e.0260@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VVxKSp6e=j8YM8JBrhsF+T=0=8xDjd_817hphOMWHVFA@mail.gmail.com>
References: <20190501043734.26706-1-bjorn.andersson@linaro.org> <20190501043734.26706-3-bjorn.andersson@linaro.org> <CAD=FV=VVxKSp6e=j8YM8JBrhsF+T=0=8xDjd_817hphOMWHVFA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] soc: qcom: Add AOSS QMP driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 23 May 2019 11:05:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2019-05-23 09:38:13)
> Hi,
>=20
> On Tue, Apr 30, 2019 at 9:38 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>=20
> > +static int qmp_qdss_clk_add(struct qmp *qmp)
> > +{
> > +       struct clk_init_data qdss_init =3D {
> > +               .ops =3D &qmp_qdss_clk_ops,
> > +               .name =3D "qdss",
> > +       };
>=20
> Can't qdss_init be "static const"?  That had the advantage of not
> needing to construct it on the stack and also of it having a longer
> lifetime.  It looks like clk_register() stores the "hw" pointer in its
> structure and the "hw" structure will have a pointer here.  While I
> can believe that it never looks at it again, it's nice if that pointer
> doesn't point somewhere on an old stack.
>=20
> I suppose we could go the other way and try to mark more stuff in this
> module as __init and __initdata, but even then at least the pointer
> won't be onto a stack.  ;-)
>=20

Const would be nice, but otherwise making it static isn't a good idea.
The clk_init_data structure is all copied over, although we do leave a
dangling pointer to it stored inside the clk_hw structure we don't use
it after clk registration. Maybe we should overwrite the pointer with
NULL once we're done in clk_register() so that clk providers can't use
it. It might break somebody but would at least clarify this point.

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..56997a974408 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3438,9 +3438,9 @@ static int clk_cpy_name(const char **dst_p, const cha=
r *src, bool must_exist)
 	return 0;
 }
=20
-static int clk_core_populate_parent_map(struct clk_core *core)
+static int clk_core_populate_parent_map(struct clk_core *core,
+					const struct clk_init_data *init)
 {
-	const struct clk_init_data *init =3D core->hw->init;
 	u8 num_parents =3D init->num_parents;
 	const char * const *parent_names =3D init->parent_names;
 	const struct clk_hw **parent_hws =3D init->parent_hws;
@@ -3520,6 +3520,14 @@ __clk_register(struct device *dev, struct device_nod=
e *np, struct clk_hw *hw)
 {
 	int ret;
 	struct clk_core *core;
+	const struct clk_init_data *init =3D hw->init;
+
+	/*
+	 * The init data is not supposed to be used outside of registration path.
+	 * Set it to NULL so that provider drivers can't use it either and so that
+	 * we catch use of hw->init early on in the core.
+	 */
+	hw->init =3D NULL;
=20
 	core =3D kzalloc(sizeof(*core), GFP_KERNEL);
 	if (!core) {
@@ -3527,17 +3535,17 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
 		goto fail_out;
 	}
=20
-	core->name =3D kstrdup_const(hw->init->name, GFP_KERNEL);
+	core->name =3D kstrdup_const(init->name, GFP_KERNEL);
 	if (!core->name) {
 		ret =3D -ENOMEM;
 		goto fail_name;
 	}
=20
-	if (WARN_ON(!hw->init->ops)) {
+	if (WARN_ON(!init->ops)) {
 		ret =3D -EINVAL;
 		goto fail_ops;
 	}
-	core->ops =3D hw->init->ops;
+	core->ops =3D init->ops;
=20
 	if (dev && pm_runtime_enabled(dev))
 		core->rpm_enabled =3D true;
@@ -3546,13 +3554,13 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
 	if (dev && dev->driver)
 		core->owner =3D dev->driver->owner;
 	core->hw =3D hw;
-	core->flags =3D hw->init->flags;
-	core->num_parents =3D hw->init->num_parents;
+	core->flags =3D init->flags;
+	core->num_parents =3D init->num_parents;
 	core->min_rate =3D 0;
 	core->max_rate =3D ULONG_MAX;
 	hw->core =3D core;
=20
-	ret =3D clk_core_populate_parent_map(core);
+	ret =3D clk_core_populate_parent_map(core, init);
 	if (ret)
 		goto fail_parents;
=20

>=20
>=20
> > +static void qmp_pd_remove(struct qmp *qmp)
> > +{
> > +       struct genpd_onecell_data *data =3D &qmp->pd_data;
> > +       struct device *dev =3D qmp->dev;
> > +       int i;
> > +
> > +       of_genpd_del_provider(dev->of_node);
> > +
> > +       for (i =3D 0; i < data->num_domains; i++)
> > +               pm_genpd_remove(data->domains[i]);
>=20
> Still feels like the above loop would be better as:
>   for (i =3D data->num_domains - 1; i >=3D 0; i--)
>=20

Reason being to remove in reverse order? Otherwise this looks like an
opinion.
