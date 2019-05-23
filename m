Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3119C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B99217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kBPQm5Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfEWSgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:36:12 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34773 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:36:12 -0400
Received: by mail-ua1-f66.google.com with SMTP id 7so2570371uah.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb3kcsO8m+4TP5So6BQHRuZ04N7TnwT1M9UllMU7t6E=;
        b=kBPQm5PuV61p3BztiKcUUjRQQxcFFw2xWcQGZanAo81A1y1Q1yGwTgM4mTChPqVyhO
         1Bg09iaXCxSRIbegFzmT05/b966T70N797fQ/TLrvDq8om/GWNeNVmNnnP3XZT5B+rHx
         05civqhn8gKGBTvE7N0pXBsR3q7p/Q89UtNqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb3kcsO8m+4TP5So6BQHRuZ04N7TnwT1M9UllMU7t6E=;
        b=Wp/ymmu/cjnujHmf6/SBgvqhxJLKrMV3NxBCaYoIl+uLCfwO31oR9IhdDF4xAx9iGd
         ZGp6nbiuZjZ+IcgdbvDc4RgBIAe1astXfwgrLJc1GOjKC6ZYZz2330fWJlZ2F1/q9DSw
         eNr/lSPTfLoSgKhOlreV1AE1ST0/TAYGdFnLT75Z6HvwZxHJh/FceuUkTfl/PKgT6Zm8
         TlKglKBIMubSzSygZxVl63hA9/d981EzEWd/1qNmPCi0lVJjqW9A0Zu+zFYLjf/T2YeT
         Go8LCL7OibmqkjjkZ01GRGxbIMBNvW90pY8gvIEWBOkamJ9JYdnzBUoFxC6QSnck24jv
         Sh+A==
X-Gm-Message-State: APjAAAVMg3Dl1+BpKmohofW46dcenEaV9ADKKJ+bgxAbx6ec0mPTGAxn
        1npJ7MyBUif1Wdow1ula9ls+2Xp64dE=
X-Google-Smtp-Source: APXvYqwIsEfdFSKaOEBJbeymOOTkDV9VQvo7ZY1l3PLsFGm6r/pd1reZ1Qws2ZE4w4WuZ9XaNyCwIA==
X-Received: by 2002:ab0:20b3:: with SMTP id y19mr48408955ual.74.1558636570525;
        Thu, 23 May 2019 11:36:10 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id v133sm56695vkv.5.2019.05.23.11.36.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:36:09 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id r19so2561724uap.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:36:09 -0700 (PDT)
X-Received: by 2002:ab0:4a97:: with SMTP id s23mr320550uae.19.1558636568655;
 Thu, 23 May 2019 11:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190501043734.26706-1-bjorn.andersson@linaro.org>
 <20190501043734.26706-3-bjorn.andersson@linaro.org> <CAD=FV=VVxKSp6e=j8YM8JBrhsF+T=0=8xDjd_817hphOMWHVFA@mail.gmail.com>
 <5ce6e0cd.1c69fb81.9a03e.0260@mx.google.com>
In-Reply-To: <5ce6e0cd.1c69fb81.9a03e.0260@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 May 2019 11:35:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Woy4dDBZMyrUrU0UfNmp9gUs81kwHgLccvvcCdV++KgQ@mail.gmail.com>
Message-ID: <CAD=FV=Woy4dDBZMyrUrU0UfNmp9gUs81kwHgLccvvcCdV++KgQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] soc: qcom: Add AOSS QMP driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
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


On Thu, May 23, 2019 at 11:05 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2019-05-23 09:38:13)
> > Hi,
> >
> > On Tue, Apr 30, 2019 at 9:38 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> >
> > > +static int qmp_qdss_clk_add(struct qmp *qmp)
> > > +{
> > > +       struct clk_init_data qdss_init = {
> > > +               .ops = &qmp_qdss_clk_ops,
> > > +               .name = "qdss",
> > > +       };
> >
> > Can't qdss_init be "static const"?  That had the advantage of not
> > needing to construct it on the stack and also of it having a longer
> > lifetime.  It looks like clk_register() stores the "hw" pointer in its
> > structure and the "hw" structure will have a pointer here.  While I
> > can believe that it never looks at it again, it's nice if that pointer
> > doesn't point somewhere on an old stack.
> >
> > I suppose we could go the other way and try to mark more stuff in this
> > module as __init and __initdata, but even then at least the pointer
> > won't be onto a stack.  ;-)
> >
>
> Const would be nice, but otherwise making it static isn't a good idea.

Even aside from the whole "not having it store a pointer to the
stack", "static const" is likely to reduce overall memory consumption
/ number of instructions by a tiny bit because we don't need to copy
this structure onto the stack--we can just use it in place.

As written (or by just adding const but not static const): qmp_probe()
is 1840 bytes long.
...and has this snippet:

   0xffffff80084a58d4 <+1152>:  adrp    x1, 0xffffff8008a5b000
<video_cc_sdm845_match_table+280>
   0xffffff80084a58d8 <+1156>:  add     x1, x1, #0x600
   0xffffff80084a58dc <+1160>:  add     x0, sp, #0x10
   0xffffff80084a58e0 <+1164>:  mov     w2, #0x28                       // #40
   0xffffff80084a58e4 <+1168>:  add     x22, sp, #0x10
   0xffffff80084a58e8 <+1172>:  bl      0xffffff800896e800 <memcpy>


With this as static const: qmp_probe is 1820 bytes long.
...and has this snippet:

   0xffffff80084a58dc <+1160>:  adrp    x8, 0xffffff8008a5b000
<video_cc_sdm845_match_table+280>
   0xffffff80084a58e0 <+1164>:  add     x8, x8, #0x550



> The clk_init_data structure is all copied over, although we do leave a
> dangling pointer to it stored inside the clk_hw structure we don't use
> it after clk registration. Maybe we should overwrite the pointer with
> NULL once we're done in clk_register() so that clk providers can't use
> it. It might break somebody but would at least clarify this point.

Setting it to NULL seems like it would be a good idea.  Now that I
think on it I believe I've actually tripped over this before trying to
read the '.name' from here...  :-P


> > > +static void qmp_pd_remove(struct qmp *qmp)
> > > +{
> > > +       struct genpd_onecell_data *data = &qmp->pd_data;
> > > +       struct device *dev = qmp->dev;
> > > +       int i;
> > > +
> > > +       of_genpd_del_provider(dev->of_node);
> > > +
> > > +       for (i = 0; i < data->num_domains; i++)
> > > +               pm_genpd_remove(data->domains[i]);
> >
> > Still feels like the above loop would be better as:
> >   for (i = data->num_domains - 1; i >= 0; i--)
> >
>
> Reason being to remove in reverse order? Otherwise this looks like an
> opinion.

1. Matches the order of the error handling case above (see unroll_genpds label)

2. In general you avoid more unexpected problems by un-initting in the
reverse order you initted.


-Doug
