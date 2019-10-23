Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A00BCA9EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA28205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BG0rvQs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407891AbfJWWcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:32:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35623 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407881AbfJWWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:32:30 -0400
Received: by mail-io1-f66.google.com with SMTP id t18so22872009iog.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7cbIsGfkqhBHDWvtTguhXtuuBK8gPXcdqakL847UDEs=;
        b=BG0rvQs3Wz4MRf7d1g0eMVHiI5O3zYGmQHuTyAH+t10Vwfd7M9EJHjbEHf0chlmsjn
         vw192TjYMGE3sQ2UkfUdFsGEYDJdB7yb1LdQHghyvRm+2vTjgzMRlFpt0Gl2PrAyKAX6
         a9b7ABnRARSbNzerTzjePufXdhjqB3elNMkhl3fh6LfVDAkvJtXKnOJjI+iIMRbD2UXn
         E0tJuP9MCBgb67b9Qh8oFpcVjLnx+1K1urJ5AZg2mL9s0C5ryLziiezzCsoAMX6smeLC
         HhCci4UtySrOyO1tF5HSeJPhIm2/zyffoUXvtiXwrnOkCo0ryASnOd56P0WLXjIdcKil
         O4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7cbIsGfkqhBHDWvtTguhXtuuBK8gPXcdqakL847UDEs=;
        b=AyiDw2jTuyjcjFfqNA41XxDn3ksakaBqcvu4vWnnAccRE93FdEDO5LYwkwHf19xhRC
         UZqoePzeje8REZoHwz0Vxn1oG0zCWcH+aL0PGrksQWF6GTMt/w1gtvsMrqRcScIyOmYc
         dZtm4CkAmlBAd0s3sYVbE9/7vDBFLEU3T8km2jeCL7SbwzGbvIuJ/hf66j07pEQ4mFBG
         Au0o2NIGm4M+p7ynGDRDSMWmH0XyXpsmV8rvzcN+8oqUazk6+/0qk3bcCbM2kKfEMSAN
         Z3hC9PXOxm/i1isW7K8cRD/x9ABA0y4OukrDGdj8Y1PBtUp5byH87yTsn0OzNzSW34Wj
         Y+DQ==
X-Gm-Message-State: APjAAAUTGw2sBhSJV59aFjcHAe5w8OdG6Z1GrsHOu1bbfme4mY5Xmsvm
        QMo3tGfBGZwIm/P6T5AxhQgRZg==
X-Google-Smtp-Source: APXvYqz7IhPLaMV1MS+oQ4RFxeNufaobr3I/FuOVjUA+OvozN2JieVdy/hq3E+oQjuOdusnZqaYQsA==
X-Received: by 2002:a6b:37c6:: with SMTP id e189mr5746348ioa.122.1571869949772;
        Wed, 23 Oct 2019 15:32:29 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z18sm2325025iob.47.2019.10.23.15.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:32:29 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:32:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <green.hu@gmail.com>
cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/8] riscv: mark some code and data as file-static
In-Reply-To: <CAEbi=3dk0R3HMnqsK1mSm2bewecdHm279f9zEq1pHWLPo9tdAg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910231531480.6074@viisi.sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com> <20191018080841.26712-6-paul.walmsley@sifive.com> <CAEbi=3dk0R3HMnqsK1mSm2bewecdHm279f9zEq1pHWLPo9tdAg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1254959037-1571869946=:6074"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1254959037-1571869946=:6074
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Oct 2019, Greentime Hu wrote:

> Paul Walmsley <paul.walmsley@sifive.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=
=8819=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:58=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Several functions and arrays which are only used in the files in which
> > they are declared are missing "static" qualifiers.  Warnings for these
> > symbols are reported by sparse:
> >
> > arch/riscv/kernel/stacktrace.c:22:14: warning: symbol 'walk_stackframe'=
 was not declared. Should it be static?

[ ... ]

> I think walk_stackframe() could not be static because it will be used
> in perf_callchain.c.

Thanks Greentime - will update the patch.


- Paul
--8323329-1254959037-1571869946=:6074--
