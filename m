Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1373C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9436F218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgLgZhkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfGWAFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:05:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33711 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfGWAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:05:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so19783139plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=uoHZGPhy7AaMBBkhIfbi+3coowHMdF6umFxF94wcksg=;
        b=VgLgZhkEw8c6bGaz8lCXFux+cen+0GeTncyzKcaz4eOQUkOCuYdm1vzo16ayzWEfFH
         SHHI1FmMYtbVCh78rrfbsteiwlxOg1o6N1Z3aRpjghlOjBWowZ38LG6oUU0g+HI0YBZv
         sAbfVWkDIvYzhymezHOXRGayAwrp6CO/wsc6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=uoHZGPhy7AaMBBkhIfbi+3coowHMdF6umFxF94wcksg=;
        b=YuckWst9jxHASHeCX/AndkgnuZAiY1SViCPKtbVXa7DpzF+d2Cf2BRfHZZ4X5ERWZl
         +t/IV+xxsL/31VSSM/OSnObQiMme87Gdrve4yF+BPu9wTjqzrc7RjhT3+Yk5pEPo0zG8
         lAYrouVldlc5Av7LZ5nD1iysiu5ImbnAFcuNphhWfatJrllu5Z99DieAqu26uOCsqH7o
         wqKARktYfYbg5yptoF2UzkNgjSHi395weOaDnXx44xN7JjjWxFGEBVYa9iNcTSXkrVnr
         WDN+9wI9JxS6/sZhJth7q6tvPLb54wTnaJ0t9xfQskcoaKY3PGUrCwY2HPKlbORqgJbM
         2Xig==
X-Gm-Message-State: APjAAAX6oJthuTPzhNC/X5S+aNQJxliloAZzp47+ZjhRkuwctsFBBKsP
        nggReeTQTUOhGQhmbNeXUGALcA==
X-Google-Smtp-Source: APXvYqz9Y79Y2hjotjF63w3SFn2Q50huZigbPYsa8KikfgPCyQ+KkptwTSbwCGdTjHMkSd86GOlu5w==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr33344225pla.212.1563840299152;
        Mon, 22 Jul 2019 17:04:59 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k64sm21699923pge.65.2019.07.22.17.04.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 17:04:58 -0700 (PDT)
Message-ID: <5d364f2a.1c69fb81.e3ed.7bfd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722232719.GT30636@minitux>
References: <23774.56553.445601.436491@mariner.uk.xensource.com> <20190517210923.202131-3-swboyd@chromium.org> <20190722232719.GT30636@minitux>
Subject: Re: [PATCH 2/3] firmware: qcom_scm: Cleanup code in qcom_scm_assign_mem()
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ian Jackson <ian.jackson@citrix.com>,
        Julien Grall <julien.grall@arm.com>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 17:04:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-07-22 16:27:19)
> On Fri 17 May 14:09 PDT 2019, Stephen Boyd wrote:
>=20
> > There are some questionable coding styles in this function. It looks
> > quite odd to deref a pointer with array indexing that only uses the
> > first element. Also, destroying an input/output variable halfway through
> > the function and then overwriting it on success is not clear. It's
> > better to use a local variable and the kernel macros to step through
> > each bit set in a bitmask and clearly show where outputs are set.
> >=20
> > Cc: Ian Jackson <ian.jackson@citrix.com>
> > Cc: Julien Grall <julien.grall@arm.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/firmware/qcom_scm.c | 34 ++++++++++++++++------------------
> >  include/linux/qcom_scm.h    |  9 +++++----
> >  2 files changed, 21 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 0c63495cf269..153f13f72bac 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -443,7 +443,8 @@ EXPORT_SYMBOL(qcom_scm_set_remote_state);
> >   */
> >  int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> >                       unsigned int *srcvm,
> > -                     struct qcom_scm_vmperm *newvm, int dest_cnt)
> > +                     const struct qcom_scm_vmperm *newvm,
> > +                     unsigned int dest_cnt)
> >  {
> >       struct qcom_scm_current_perm_info *destvm;
> >       struct qcom_scm_mem_map_info *mem_to_map;
> > @@ -458,11 +459,10 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, siz=
e_t mem_sz,
> >       int next_vm;
> >       __le32 *src;
> >       void *ptr;
> > -     int ret;
> > -     int len;
> > -     int i;
> > +     int ret, i, b;
> > +     unsigned long srcvm_bits =3D *srcvm;
> > =20
> > -     src_sz =3D hweight_long(*srcvm) * sizeof(*src);
> > +     src_sz =3D hweight_long(srcvm_bits) * sizeof(*src);
> >       mem_to_map_sz =3D sizeof(*mem_to_map);
> >       dest_sz =3D dest_cnt * sizeof(*destvm);
> >       ptr_sz =3D ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
> > @@ -475,28 +475,26 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, siz=
e_t mem_sz,
> > =20
> >       /* Fill source vmid detail */
> >       src =3D ptr;
> > -     len =3D hweight_long(*srcvm);
> > -     for (i =3D 0; i < len; i++) {
> > -             src[i] =3D cpu_to_le32(ffs(*srcvm) - 1);
> > -             *srcvm ^=3D 1 << (ffs(*srcvm) - 1);
> > -     }
> > +     i =3D 0;
> > +     for_each_set_bit(b, &srcvm_bits, sizeof(srcvm_bits))
>=20
> The modem is sad that you only pass 8 here. Changed it to BITS_PER_LONG
> to include the modem's permission bit and applied all three patches.
>=20

Ah of course. Thanks.

BTW, srcvm is an unsigned int, but then we do a bunch of unsigned long
operations on them. Maybe the whole API should be changed to be more
explicit about the size of the type, i.e. u64?

