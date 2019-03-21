Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B7218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="Egda2+X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfCUBfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:35:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39106 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCUBfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:35:06 -0400
Received: by mail-io1-f66.google.com with SMTP id e13so3943996ioq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=giEfLeJ+F471AaNm2OTGUFSTUAxx2aJZ8BVw4sCv8HY=;
        b=Egda2+X7ZSiOQKaamcHr5m9f4ulwyyiEoYZKN6Jg0Xj1kr2UWpUPaIBAp9WTCpGvsB
         64NfpJOJn9WQHf9E3nILnOCf7bdVrM6hHGF0w/wPy2mKxWDOpYrMKuns+90xzK1AkWrL
         hhBd/0vAMwReBcjqZPE5xROuEi2vP8djJgrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=giEfLeJ+F471AaNm2OTGUFSTUAxx2aJZ8BVw4sCv8HY=;
        b=bMR2GZjLdW1sh5gn3XBlfD7bFXumr+Z1auFU/sjJg00UA1Q8Hb6OuCQ/gEJNgHAN4i
         4KlqEFyagfPCiEHdKc583J+pLmE4P5BlwvPC4U1YcwJqSTyfuQLP023rjY18YwPW88c6
         wNVtVXmWN40SybjZaw2MGdJwpR98wmgMoLIfJXkIZN7QXJLwYMvkf3EluhIzhUOH2xB9
         5u3oCQuqT626zcPctLrUCD7grAKSq3eiFzIbhr0ihMVBW2Dc06Nb1Sb2Lf4DEoOowiug
         vC9GsJ02f3A7WiDwiQ4UYYlwl8XVAOv/NSuY6Lq703UoL8dnKb5+qZyhN1VDGLs3QTV7
         aGAw==
X-Gm-Message-State: APjAAAVd70JVV1LYws9gVaj317A/LfanwnEXI9LJw+v+PPFLJlEcfRNK
        EFEYdnFTKrVlkTkDOi1rj6kmzQ==
X-Google-Smtp-Source: APXvYqzbr8koZpFTH6wc87Cp9zu44vOKJDDJMI68yrcQY7ZnOhV/EMbhRFB37kK8T0Y7YCEioM9NdQ==
X-Received: by 2002:a6b:7219:: with SMTP id n25mr879016ioc.117.1553132105179;
        Wed, 20 Mar 2019 18:35:05 -0700 (PDT)
Received: from ?IPv6:2600:16f6:ca87:f0c0:4ecc:6aff:fef9:fd54? ([2600:16f6:ca87:f0c0:4ecc:6aff:fef9:fd54])
        by smtp.gmail.com with ESMTPSA id t10sm1857412itc.37.2019.03.20.18.35.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 18:35:04 -0700 (PDT)
Message-ID: <d45d021c5546a301cf1c53d6b6d8c83ebd802a57.camel@kepstin.ca>
Subject: Re: [PATCH v3 2/2] [WIP] tools/power turbostat: Also read package
 power on AMD F17h (Zen)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 21:35:03 -0400
In-Reply-To: <CAJvTdKmXSQyY-Jdv7OkseHEE-76oDPLeJ8v8ShApDRKqWsukSQ@mail.gmail.com>
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
         <20180817163442.10065-3-calvin.walton@kepstin.ca>
         <CAJvTdKmXSQyY-Jdv7OkseHEE-76oDPLeJ8v8ShApDRKqWsukSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.0 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Whoops, resending this message. Forgot that Gmail defaulted to
HTML...)

On Wed, 2019-03-20 at 19:36 -0400, Len Brown wrote:
> Hi Calvin,
> I'm inclined to apply this -- because it will not break anything,
> and it would at least enable testing by people, who have this
> hardware.

Hi Len,

By all means go ahead and apply the package power patch as well. I've
tested it on both Summit (single-die desktop) and Raven (desktop/laptop
apu) with good results. The worst case as it stands is that if the
multi-die packages (EPYC/TR) don't aggregate the value per package,
then package power will be under-reported.

(I previously wrote that this would be easier to test with the patch
applied, because the package power is reported with the -Dump option,
but I'm not sure that's actually the case - the value might still only
be collected once per package?)

Calvin.

> 
> On Fri, Aug 17, 2018 at 12:35 PM Calvin Walton <
> calvin.walton@kepstin.ca> wrote:
> > The package power can also be read from an MSR. It's not clear
> > exactly
> > what is included, and whether it's aggregated over all nodes or
> > reported separately.
> > 
> > It does look like this is reported separately per CCX (I get a
> > single
> > value on the Ryzen R7 1700), but it might be reported separately
> > per-
> > die (node?) on larger processors. If that's the case, it would have
> > to
> > be recorded per node and aggregated for the socket.
> > 
> > Note that although Zen has these MSRs reporting power, it looks
> > like
> > the actual RAPL configuration (power limits, configured TDP) is
> > done
> > through PCI configuration space. I have not yet found any public
> > documentation for this.
> > 
> > Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/power/x86/turbostat/turbostat.c
> > b/tools/power/x86/turbostat/turbostat.c
> > index 89d4e2e75774..675c894b8595 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -1973,6 +1973,11 @@ int get_counters(struct thread_data *t,
> > struct core_data *c, struct pkg_data *p)
> >                         return -16;
> >                 p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
> >         }
> > +       if (do_rapl & RAPL_AMD_F17H) {
> > +               if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
> > +                       return -13;
> > +               p->energy_pkg = msr & 0xFFFFFFFF;
> > +       }
> >         if (DO_BIC(BIC_PkgTmp)) {
> >                 if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS,
> > &msr))
> >                         return -17;
> > @@ -3986,10 +3991,13 @@ void rapl_probe_amd(unsigned int family,
> > unsigned int model)
> >         switch (family) {
> >         case 0x17: /* Zen, Zen+ */
> >                 do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
> > -               if (rapl_joules)
> > +               if (rapl_joules) {
> > +                       BIC_PRESENT(BIC_Pkg_J);
> >                         BIC_PRESENT(BIC_Cor_J);
> > -               else
> > +               } else {
> > +                       BIC_PRESENT(BIC_PkgWatt);
> >                         BIC_PRESENT(BIC_CorWatt);
> > +               }
> >                 break;
> >         default:
> >                 return;
> > --
> > 2.18.0
> > 
> 
> 

