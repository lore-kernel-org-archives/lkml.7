Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B70C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538532199C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK/SXbvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfGWAVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:21:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39692 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbfGWAVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:21:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so18446876pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P2jEpwGpnd2dP73asPYYWzs20ZqCHZiPzV1J2BDG/FM=;
        b=GK/SXbvV1Wr4pf7vNg3Pxg2AZOAZ2PQr0KDAiEQohcxjlEhg05Y19+//vNZ4xM6+7z
         jubrtTlH/DLGGDJHi9lqywuS9zv8WwTAV+0JLL/wkH1ZQJuBNYQ8099vIYZN1q2lHybo
         n8nJcMtxlQuyn+jP3BC2/Y31PmkTFIMJQlW8+roC/guCjBRhc2F+r/PQKv762R0xxTyp
         z6khMVNYg0QMSnumu6aqcf6tQCbUy/HqcA+aKQGJRIZN3yw6TEL2QEvjvyxU+xXAPaPM
         D+kmGuwTFeWket9xNOP1+F3knKSiWW4GnDJQR8X9NgnhMdVHDFcpa17XpKOPmxPsI3IU
         vN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2jEpwGpnd2dP73asPYYWzs20ZqCHZiPzV1J2BDG/FM=;
        b=ZxySt3PiJCizYUlDAGLEfEC+oa19IkTn6NCJ66i72tKfNdPvKg72nbUlDH60wF8YAO
         tMQJJcd5nugmOiY2EYztVBz5+B7W5o6ApPjmYIzQnD4vvNHZeoq0lJdZcJgrMsOyMLHf
         goZKg765MGTSNl2O8+KKjuNMnF8KLKBxGvd7/xY6IyUprX1u35jZiH9OT+Jsik06jA3a
         ME36vtqKadl1UBDV3iC+QnzgG09CCRpHJGl7gHF3oLb1gAiZk+m5Z3PXksBw7NNWoOaa
         OrUHz8/jvIgMS5F48kd0ZXpCCNyPJItWbRHOWJqYMBc3rbuBJvs58443mGL650KzTELV
         XXAQ==
X-Gm-Message-State: APjAAAWZhQ4PBekPE41Nxi23qcekLtVbrNEqpdeZgy73XafCWOvLHwqo
        QTZXc/orfutdmlRK82GxG8zHIQ==
X-Google-Smtp-Source: APXvYqz69KfsjPqZi5pU8mg3mc+WpiAvmeiznQoHXLdW/4Mc18ndLJOVa/fhWg2UAYXvlSiPScoojQ==
X-Received: by 2002:a65:690e:: with SMTP id s14mr60618843pgq.47.1563841292767;
        Mon, 22 Jul 2019 17:21:32 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x128sm71062102pfd.17.2019.07.22.17.21.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 17:21:32 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:21:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ian Jackson <ian.jackson@citrix.com>,
        Julien Grall <julien.grall@arm.com>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Subject: Re: [PATCH 2/3] firmware: qcom_scm: Cleanup code in
 qcom_scm_assign_mem()
Message-ID: <20190723002130.GU30636@minitux>
References: <23774.56553.445601.436491@mariner.uk.xensource.com>
 <20190517210923.202131-3-swboyd@chromium.org>
 <20190722232719.GT30636@minitux>
 <5d364f2a.1c69fb81.e3ed.7bfd@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d364f2a.1c69fb81.e3ed.7bfd@mx.google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jul 17:04 PDT 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-07-22 16:27:19)
> > On Fri 17 May 14:09 PDT 2019, Stephen Boyd wrote:
> > 
> > > There are some questionable coding styles in this function. It looks
> > > quite odd to deref a pointer with array indexing that only uses the
> > > first element. Also, destroying an input/output variable halfway through
> > > the function and then overwriting it on success is not clear. It's
> > > better to use a local variable and the kernel macros to step through
> > > each bit set in a bitmask and clearly show where outputs are set.
> > > 
> > > Cc: Ian Jackson <ian.jackson@citrix.com>
> > > Cc: Julien Grall <julien.grall@arm.com>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/firmware/qcom_scm.c | 34 ++++++++++++++++------------------
> > >  include/linux/qcom_scm.h    |  9 +++++----
> > >  2 files changed, 21 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > > index 0c63495cf269..153f13f72bac 100644
> > > --- a/drivers/firmware/qcom_scm.c
> > > +++ b/drivers/firmware/qcom_scm.c
> > > @@ -443,7 +443,8 @@ EXPORT_SYMBOL(qcom_scm_set_remote_state);
> > >   */
> > >  int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >                       unsigned int *srcvm,
> > > -                     struct qcom_scm_vmperm *newvm, int dest_cnt)
> > > +                     const struct qcom_scm_vmperm *newvm,
> > > +                     unsigned int dest_cnt)
> > >  {
> > >       struct qcom_scm_current_perm_info *destvm;
> > >       struct qcom_scm_mem_map_info *mem_to_map;
> > > @@ -458,11 +459,10 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >       int next_vm;
> > >       __le32 *src;
> > >       void *ptr;
> > > -     int ret;
> > > -     int len;
> > > -     int i;
> > > +     int ret, i, b;
> > > +     unsigned long srcvm_bits = *srcvm;
> > >  
> > > -     src_sz = hweight_long(*srcvm) * sizeof(*src);
> > > +     src_sz = hweight_long(srcvm_bits) * sizeof(*src);
> > >       mem_to_map_sz = sizeof(*mem_to_map);
> > >       dest_sz = dest_cnt * sizeof(*destvm);
> > >       ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
> > > @@ -475,28 +475,26 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >  
> > >       /* Fill source vmid detail */
> > >       src = ptr;
> > > -     len = hweight_long(*srcvm);
> > > -     for (i = 0; i < len; i++) {
> > > -             src[i] = cpu_to_le32(ffs(*srcvm) - 1);
> > > -             *srcvm ^= 1 << (ffs(*srcvm) - 1);
> > > -     }
> > > +     i = 0;
> > > +     for_each_set_bit(b, &srcvm_bits, sizeof(srcvm_bits))
> > 
> > The modem is sad that you only pass 8 here. Changed it to BITS_PER_LONG
> > to include the modem's permission bit and applied all three patches.
> > 
> 
> Ah of course. Thanks.
> 
> BTW, srcvm is an unsigned int, but then we do a bunch of unsigned long
> operations on them. Maybe the whole API should be changed to be more
> explicit about the size of the type, i.e. u64?
> 

It's a bitmap of vmids currently with access to the region and the space
has expanded since I looked at this list time, so the now highest
defined id in the downstream kernel is 42.

So it sounds very reasonable to expand this to a u64.

Regards,
Bjorn
