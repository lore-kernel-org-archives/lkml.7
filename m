Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B69CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B48C217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEHHtXeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfHHG1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:27:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43727 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:27:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so19093560wru.10;
        Wed, 07 Aug 2019 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pmLe+2hh12AV2fWDLuCLoZwfalLPQvLzD4g62m50b0k=;
        b=CEHHtXeFjhD+tzAhZywdJN5LwSzFPBqCcPSeVgeVB0ZC8DV1HXnAJ6FiFTZsAFvsVn
         wdncjRt3iob6EbqT5FgWKKUJ+mD55V03FSv8G2E4O0KfIbzha6KDxSJO1QE7DqUl2Goy
         uSwk8JviSdCfCLYjlcNRnTddNDKJscCudG86FTGDWPEOMFmapV90N2vff9vf/4ichait
         OfP6P4oxvTaHHvCb1GV+2ko5/wBg+MmCPqbc33E98ssCFewIZrEM0Q0pGklNxnvPIUKP
         savgTzmYGDzDtiRd1TALzqoYIJ/jRrjeU9XCuM2iOdjZNAH0mtqNd/T8K7ILqvY9q6rD
         KPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pmLe+2hh12AV2fWDLuCLoZwfalLPQvLzD4g62m50b0k=;
        b=N+wWq6jpZFv5/C8xQ7MyWfNctCcWAYZHYnucZs/1T6N5j/Unj1WBqP2V2KnK18j4z/
         qMSYPDTDaUpoqVd2BUfUyFIterNuo/0P2YI/JBgsUsJNnUIc0QA6veijS/++yDehhFpm
         YzC6RJlyMTotTniTr6wyNOjMV7XXLwUfEEZMIZ2ZF6HYDlOl+xytEHRgwKn87AUzEVFX
         5iTlOy+DW01OVox4mlLvJnO8i2PjpydhYlpZ1o4bdfCGZ8xrk/q2dcRG/kp9bLOVwIFE
         ta7hH7/5prylIuJDkrBh7WTnHxteSar0cJM+POOl5aLsq7/tYehkrVvEepuB6d6elCcr
         vhpw==
X-Gm-Message-State: APjAAAXgcQAl6i709nrpBagUE59zAibfQb080zeiP16wZsHEsuy5Ykcx
        Mmc7Wo0HjaHYHDZWLev77kZSfUf5C5KlMrXiqYK2mGhdCyE=
X-Google-Smtp-Source: APXvYqyhsrFyIH7cz50WRIDklFfrjHJbj5ngQDSOUJ0FlFhaOO1kHA+UywUlX5g2SYIxq9GcmgjdbYu20O/31kXZY3E=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr15347063wrs.93.1565245669397;
 Wed, 07 Aug 2019 23:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com> <CAEnQRZDr+gj_eiESLNbVUVy1rreRE1nnDgtb3g=CjaRF5Aq9Vw@mail.gmail.com>
 <CAEnQRZDctjdzQ2RjJXhQh+s=d0y_j3Taa51hDaR4bqJ62C=7iQ@mail.gmail.com>
 <85b4a2c4-761e-bdcf-f05e-2fb16c06f11e@linux.intel.com> <CAEnQRZCE3mxorYpL_nPXiU4MezGDaqUfuFDx8ci0WdXzDa68JA@mail.gmail.com>
In-Reply-To: <CAEnQRZCE3mxorYpL_nPXiU4MezGDaqUfuFDx8ci0WdXzDa68JA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 8 Aug 2019 09:27:37 +0300
Message-ID: <CAEnQRZCmKXNxx=mjHRcn6rYQJxzaaPLL4WQf79RZ5Aqdzqcu3Q@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH v2 3/5] ASoC: SOF: Add DT DSP device support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 6:28 PM Daniel Baluta <daniel.baluta@gmail.com> wrot=
e:
>
> On Wed, Aug 7, 2019 at 6:22 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> >
> >
> > >>>> +static int sof_dt_probe(struct platform_device *pdev)
> > >>>> +{
> > >>>> +     struct device *dev =3D &pdev->dev;
> > >>>> +     const struct sof_dev_desc *desc;
> > >>>> +     /*TODO: create a generic snd_soc_xxx_mach */
> > >>>> +     struct snd_soc_acpi_mach *mach;
> > >>>
> > >>> I wonder if you really need to use the same structures. For Intel w=
e get
> > >>> absolutely zero info from the firmware so rely on an ACPI codec ID =
as a
> > >>> key to find information on which firmware and topology to use, and =
which
> > >>> machine driver to load. You could have all this information in a DT=
 blob?
> > >>
> > >> Yes. I see your point. I will still need to make a generic structure=
 for
> > >> snd_soc_acpi_mach so that everyone can use sof_nocodec_setup functio=
n.
> > >>
> > >> Maybe something like this:
> > >>
> > >> struct snd_soc_mach {
> > >>    union {
> > >>    struct snd_soc_acpi_mach acpi_mach;
> > >>    struct snd_soc_of_mach of_mach;
> > >>    }
> > >> };
> > >>
> > >> and then change the prototype of sof_nocodec_setup.
> > >
> > > Hi Pierre,
> > >
> > > I fixed all the comments except the one above. Replacing snd_soc_acpi=
_mach
> > > with a generic snd_soc_mach is not trivial task.
> > >
> > > I wonder if it is acceptable to get the initial patches as they are
> > > now and later switch to
> > > generic ACPI/OF abstraction.
> > >
> > > Asking this because for the moment on the i.MX side I have only
> > > implemented no codec
> > > version and we don't probe any of the machine drivers we have.
> > >
> > > So, there is this only one member of snd_soc_acpi_mach that imx
> > > version is making use of:
> > >
> > >    mach->drv_name =3D "sof-nocodec";
> > >
> > > That's all.
> > >
> > > I think the change as it is now is very clean and non-intrusive. Late=
r
> > > we will get options to
> > > read firmware name and stuff from DT.
> > >
> > > Anyhow, I don't think we can get rid of snd_dev_desc structure on
> > > i.MX. This will be used
> > > to store the information read from DT:
> > >
> > > static struct sof_dev_desc sof_of_imx8qxp_desc =3D {
> > > =C2=BB       .default_fw_path =3D "imx/sof",
> > > =C2=BB       .default_tplg_path =3D "imx/sof-tplg",
> > > =C2=BB       .nocodec_fw_filename =3D "sof-imx8.ri",
> > > =C2=BB       .nocodec_tplg_filename =3D "sof-imx8-nocodec.tplg",
> > > =C2=BB       .ops =3D &sof_imx8_ops,
> > > };
> > >
> > > For the moment we will only use the default values.
> >
> > Yes, that's fine for now. If you don't have a real machine driver then
> > there's nothing urgent to change.
> >
> > Is the new version on GitHub?
>
> Not yet, will push it today and ping you.

PR updated: https://github.com/thesofproject/linux/pull/1048
