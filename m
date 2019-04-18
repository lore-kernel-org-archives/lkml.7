Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A9C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828D6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoU9tiDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfDRIDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:03:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44898 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:03:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so811026pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+AcexFMyMV8J9T4qaaiOIbAuRbOHeJ5v2ghunSbBPws=;
        b=KoU9tiDFNy/SfiGvLelvpEoklY4NKmsjJk9yitVcyFbcDCltCLOAXmUtuDvVNteD8G
         +BFVVantAaV1AItQq+6OtHbUb4RoFl6PXdbfP17LXgfWkTdyP/ICNrvwu0vnLdKShHkL
         pU405XnZK+7hY09ALpr9j6HDYSw0xnEgN0lZhfqRI2fInkXOyhcIJS7HJwmO3NjokhbC
         3zm5eWlUbOEME4Mf3MrljVKUAoz3rjlP+MsovqQe/JVoI7yPO0sl2Ki6eKvldtDM11Br
         bsEB/2xJuoeJLl9c/rR1Nb6Habkj3R3FHnjTqV0PkE6O+9FVDEDoPuF/2tX05qKFAwQ5
         L1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AcexFMyMV8J9T4qaaiOIbAuRbOHeJ5v2ghunSbBPws=;
        b=p0FTnWOLK4WthUOq/X5e1l6CHQGMLqr9M544e3BcUd1kq+maUxBoOuslacTmZbNpAc
         J7hevNx3kEJzEQEcUzW9F8Iri4pof8NqBCNcuuKSSndUDeudquGs5hqoUlj/kGcB/Z0o
         3XdnTPm3vG95YFg+qSSAkAL6tnukMSz+XNY477REf1D8WC1zqYq1mjntINWmBgACSXLv
         W3ych49/SDl+V67csMdOpF8vN0Em/JO3iMbSR3J3gvQKirlzmgL95eDtKbIDDe9vIZzK
         ISQAHgzDhK+34M7tVe5qikjmfvc2FIc5z8MPjMFz6yc0SookcUArQuW+UhykCj4TS93w
         r1Ig==
X-Gm-Message-State: APjAAAWP49Elh1BzMz8+RRdTbwgCVsiTRA0OFDuLH+gAgftv8ioZPoNs
        trOGROxmaJHTttVWdTrQoiA=
X-Google-Smtp-Source: APXvYqz4EPUVQrAJd+32ydH3bwKXIzk3V/JYPeiheBWNzOuvGWZapEQK9/munPDxHot4eUPtYunYjw==
X-Received: by 2002:a63:ef4c:: with SMTP id c12mr74651267pgk.43.1555574598950;
        Thu, 18 Apr 2019 01:03:18 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id d69sm2455676pfg.24.2019.04.18.01.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:03:18 -0700 (PDT)
Date:   Thu, 18 Apr 2019 01:03:10 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190418080309.GA9788@Asurada>
References: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 02:37:03AM +0000, S.j. Wang wrote:
> > Here:
> > > +     /* Does not support cases: Tsout > 8.125 * Tsin */
> > > +     if (inrate * 8 > 65 * outrate)

Though it might not matter any more (see my last comments),
it should be "inrate > 8.125 * outrate" in the comments.

> > > +             return -EINVAL;
> > And here:
> > > +     ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> > > +     if (ret) {
> > > +             pair_err("No supported pre-processing options\n");
> > > +             return ret;
> > > +     }
> > 
> > Instead of a general message, I was thinking of a more specific one by
> > telling users that the ratio between the two rates isn't supported --
> > something similar to what I suggested previously:
> > 
> >         pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
> >                  outrate, inrate);
> > 

> In fsl_asrc_sel_proc,  we can't call the pair_err for there is no
> struct fsl_asrc_pair *pair in the argument. Do you think we need to
> add this argument?

I's thinking of adding it to the top of fsl_asrc_config_pair()
as a part of inrate-outrate-validation, however, I found that
actually we already have a similar check in the early routine:
	if ((outrate > 8000 && outrate < 30000) &&
	    (outrate/inrate > 24 || inrate/outrate > 8)) {
		pair_err("exceed supported ratio range [1/24, 8] for \
			 inrate/outrate: %d/%d\n", inrate, outrate);
		return -EINVAL;
	}

And this is according to IMX6DQRM:
    Limited support for the case when output sampling rates is
    between 8kHz and 30kHz. The limitation is the supported ratio
    (Fsin/Fsout) range as between 1/24 to 8

This should cover your 8.125 condition already, even if having
an outrate range between [8KHz, 30KHz] check, since an outrate
above 30KHz will not have an inrate bigger than 8.125 times of
it, given the maximum input rate is 192KHz.

So I think that we can just drop that 8.125 condition from your
change and there's no need to error out any more.

However, we do need a patch to fix a potential rounding issue:
-	    (outrate/inrate > 24 || inrate/outrate > 8)) {
+	    (outrate > 24 * inrate || inrate > 8 * outrate)) {

Should fix the missing whitespace also. And it will be needed
to send to stable kernel too. Will you help submit a change?

Thanks
