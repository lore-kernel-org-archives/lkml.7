Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEB42082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpXsGGFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfHSPFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:05:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39559 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHSPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:05:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so1382899pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=2ngrUcm028FTMoHPYwWl4FMwsMbOztEIs+R4QrrR4rw=;
        b=NpXsGGFiQO2Mz4ORGbsS+ZJTAE+cCEfnpxGV7ZTaS8n+cYKW15FoD17x/Vc1KyFmNH
         PIDSLvIRG58tREVOAavFge/cofdX4gzRNlE9naek5zb4a89f/kPIGIy+pPd2CIHMli5t
         dpBhGYbbkDTo9DANgDqNa8zKrZ+xio88LhvAWsdcdNQ20UWUef69za7EvrbIxDQBDFJo
         jgCu/ZofkAe9DVOZXGNT+y7gpEzMjQQcLgq5vhd7tjWe90JsZefALpQM9YTcVVYnD6A+
         y7czBeKXh0C3yG8IHs//zk6vWHoi0sMH22tCkTTXHpEI52Zy2pjgK8xTt4SCn9GtawsW
         7szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=2ngrUcm028FTMoHPYwWl4FMwsMbOztEIs+R4QrrR4rw=;
        b=SXL54Ak8tBJiMBdD34fVUN/u//yq4K8iIkCrsP4a10NJZIchztzvs0UM+tE327T084
         BEud+/Q3Rm5df32IsKm2GoFBB0B/Ibr7VPlY1JUPaxtr7zGhUW98U2cH4brqkhpfkERS
         Dy5VspoBx47jxz1fH0uoY4ddQnrEM7yXDJ8b8dFUafkLemzDzFtCQYU/AHrHgyM7Z+7d
         JRH7bSGudCKF2R9oAiVJRMyOpT2mGFD943dKq2u/e5FxycR01z0BNWwV02nFHIzQpogI
         jB1yB3C0PI85i8FHuVsW78IvA7sBF73b8yqH+IVJf9vyqHlKehKZMY3bZ2xAOr07fwn/
         NoOA==
X-Gm-Message-State: APjAAAUht8rJoxFzs0j6wQNmVstiVVZ3HknUl9XkZyrJfm+rsNvaUi1d
        ccvUdmfmwqc/CC8oxUxL1Ks=
X-Google-Smtp-Source: APXvYqzTv8DMd0Hto6oUfVfrBBvkkCqsCKUum+sxq+xdhkH6KnGHqImWBaBZF1x5ryJuEqdshOhwMQ==
X-Received: by 2002:a17:90a:bf82:: with SMTP id d2mr10680284pjs.121.1566227123998;
        Mon, 19 Aug 2019 08:05:23 -0700 (PDT)
Received: from localhost ([61.68.68.69])
        by smtp.gmail.com with ESMTPSA id m20sm17596953pff.79.2019.08.19.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 08:05:23 -0700 (PDT)
Date:   Tue, 20 Aug 2019 01:05:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/64: optimise LOAD_REG_IMMEDIATE_SYM()
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>
References: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr>
        <92bf50b31f5f78cc76ed055b11a492e8e9e2c731.1566223054.git.christophe.leroy@c-s.fr>
        <20190819142459.GJ31406@gate.crashing.org>
In-Reply-To: <20190819142459.GJ31406@gate.crashing.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566226318.3km27rs0o4.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool's on August 20, 2019 12:24 am:
> On Mon, Aug 19, 2019 at 01:58:12PM +0000, Christophe Leroy wrote:
>> -#define LOAD_REG_IMMEDIATE_SYM(reg,expr)	\
>> -	lis     reg,(expr)@highest;		\
>> -	ori     reg,reg,(expr)@higher;	\
>> -	rldicr  reg,reg,32,31;		\
>> -	oris    reg,reg,(expr)@__AS_ATHIGH;	\
>> -	ori     reg,reg,(expr)@l;
>> +#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
>> +	lis	reg, (expr)@highest;		\
>> +	lis	tmp, (expr)@__AS_ATHIGH;	\
>> +	ori	reg, reg, (expr)@higher;	\
>> +	ori	tmp, reg, (expr)@l;		\
>> +	rldimi	reg, tmp, 32, 0
>=20
> That should be
>=20
> #define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
> 	lis	tmp, (expr)@highest;		\
> 	ori	tmp, tmp, (expr)@higher;	\
> 	lis	reg, (expr)@__AS_ATHIGH;	\
> 	ori	reg, reg, (expr)@l;		\
> 	rldimi	reg, tmp, 32, 0
>=20
> (tmp is the high half, reg is the low half, as inputs to that rldimi).

I guess the intention was also to try to fit the independent ops into
the earliest fetch/issue cycle possible.

#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
	lis	tmp, (expr)@highest;		\
	lis	reg, (expr)@__AS_ATHIGH;	\
	ori	tmp, tmp, (expr)@higher;	\
	ori	reg, reg, (expr)@l;		\
	rldimi	reg, tmp, 32, 0

Very cool series though.

Thanks,
Nick
=
