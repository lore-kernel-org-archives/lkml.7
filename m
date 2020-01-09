Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEC9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11BD206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Bq+zDCp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgAIR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:27:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44874 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgAIR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:27:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so6280437edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFFo4lYAoR+ztQi+bc+shgpxvHEpz1hycdVXq2pda/E=;
        b=Bq+zDCp8utnqC9vMcJB/9oXqT1bWMXHa9K3cjrXkVmVYBP/ZIdLLfGDxDgPktAJpPc
         uDYgQR6bCFp8fdwsIvv0sWXgr9FBuzJqreq7T9hmyWCwHAr2vcfVPJCCEUp2NECox+fi
         zmyZQ2zO+D8GV6q5/rDZdUGfjWEu3R7OzVs5gFMShCfE5zEHEqMcqaJCnCEFXBNLW0+i
         NjJvOr1EXZymyaujysT4RdeA6n0A+SRdv2jVrVR4+eqCNYkrSNwMW8weozYmXO+uiFCL
         8IomC0iUekQ+Rr41GSxJd9EGJcJ7cgy3qRopzDCAknRfsyjo1/pb+Cj7/h5dOiOqQAbp
         EfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFFo4lYAoR+ztQi+bc+shgpxvHEpz1hycdVXq2pda/E=;
        b=ghQOD7zoqLsk/45Y6YzcgkCPj/LOdayOB1YIlZt+bu3jH3XqgShIBlr5CpyyIhBMyH
         236rnlc4XY9+aUUOFYiqxoE6tfQio4F0tTcHXLwydCL+V+DNh3y63KYmVcv0MkPf6Bll
         rIA1SZra5cJoSUJkzild1nSfLKgFfIIRzNztfqkkf0f37bLOjAssYeiw8HF8Xt7ec7dT
         dKjHtckNK/nu/02fH8gyiOPyfouV2fpbCoXRVcjv4J0zFSfvV6bvuB+674/zz0PJhg20
         Hcxqcw+drDSrREQG3AkM8owaX1VxTJuJoA4sHbzg7ivEat5UZwt9AbsIRakN3zDxa+dD
         wUtw==
X-Gm-Message-State: APjAAAXi24dQZh7zfxAffTVkZouRIVHvViqtNN/8n3uX7C7M3JdnjRll
        TsFlXk9S+t+Wa9HCIHBN3W2d9CFFUbPxhMp6vg0Syl+8+2U=
X-Google-Smtp-Source: APXvYqxns+YYQrgWQriAT/C78R+M4y26/fH9IfQcErryWfYvFhFx6Chl+31zO8yU40ApwcokfeGqoyXjdVewMru6CFg=
X-Received: by 2002:a50:fb96:: with SMTP id e22mr12240111edq.18.1578590841789;
 Thu, 09 Jan 2020 09:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
 <20200107230626.885451-4-martin.blumenstingl@googlemail.com> <2ceffe46-57a8-79a8-2c41-d04b227d3792@arm.com>
In-Reply-To: <2ceffe46-57a8-79a8-2c41-d04b227d3792@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 9 Jan 2020 18:27:11 +0100
Message-ID: <CAFBinCD7o-q-i66zZhOro1DanKAfG-8obQtzxxD==xOwsy_d6A@mail.gmail.com>
Subject: Re: [PATCH RFT v1 3/3] drm/panfrost: Use the mali-supply regulator
 for control again
To:     Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        tomeu.vizoso@collabora.com, robh@kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:31 PM Steven Price <steven.price@arm.com> wrote:
>
> On 07/01/2020 23:06, Martin Blumenstingl wrote:
> > dev_pm_opp_set_rate() needs a reference to the regulator which should be
> > updated when updating the GPU frequency. The name of the regulator has
> > to be passed at initialization-time using dev_pm_opp_set_regulators().
> > Add the call to dev_pm_opp_set_regulators() so dev_pm_opp_set_rate()
> > will update the GPU regulator when updating the frequency (just like
> > we did this manually before when we open-coded dev_pm_opp_set_rate()).
>
> This patch causes a warning from debugfs on my firefly (RK3288) board:
>
> debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' already
> present!
>
> So it looks like the regulator is being added twice - but I haven't
> investigated further.
I *think* it's because the regulator is already fetched by the
panfrost driver itself to enable it
(the devfreq code currently does not support enabling the regulator,
it can only control the voltage)

I'm not sure what to do about this though

[...]
> >       ret = dev_pm_opp_of_add_table(dev);
> > -     if (ret)
> > +     if (ret) {
> > +             dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
>
> If we don't have a regulator then regulators_opp_table will be NULL and
> sadly dev_pm_opp_put_regulators() doesn't handle a NULL argument. The
> same applies to the two below calls obviously.
good catch, thank you!
are you happy with the general approach here or do you think that
dev_pm_opp_set_regulators is the wrong way to go (for whatever
reason)?


Martin
