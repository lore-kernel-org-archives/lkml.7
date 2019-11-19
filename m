Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDAAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83722222D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaCMkMwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfKSVrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:47:11 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39522 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKSVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:47:10 -0500
Received: by mail-pj1-f67.google.com with SMTP id t103so3201208pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 13:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=z0/O1Vpuw+xwM/4jaTJh2/ARW1/nXxwQlkmSxUL0re0=;
        b=BaCMkMwBvnUDcFn2Afgbc832ylHb3Li4n3kiBHbNDNumcoZCz28vAMJbW9E0ee0vie
         gSUwrOjPqwiC8bWK7cnfgMYXiHMRHknJYIUvuXa/h5fR2taBOM0UNkJ9m2/t/mqot34I
         rvM8AecLG/bdb1/PuULA0s5swchRu1MwkrVhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=z0/O1Vpuw+xwM/4jaTJh2/ARW1/nXxwQlkmSxUL0re0=;
        b=HVYJDvwfEAz56al5QJLD80JMLy2MN81GOr0xxYe4RWg/7ltzKSgpTPYE6MoRZZdAVJ
         HJM6cMmLLvCKMYmfiMvpaosKAMx96oau59QzUXvyUwcjQwD+jxwAPQr4z6Aoqeh21G1I
         8gP6JTDaiqWNeHCcbd8IWOOgWQgTF0AeC2SEBc/4MUCpD2bQBA4FUCvt0BNu/21iF0aJ
         Di3VjEe9sEnYykeIQXo0FbiqHRsAWE+rEeuUzDalbC5mMXO9t3ysGYNt/9sJcLPsQzkL
         28GZmon1gyQT3Bg9uiNgwTkuThwhTMbiaRfCp7ofsXmwcu1N7EfMAiSLOptaF5hv+1Oq
         10pQ==
X-Gm-Message-State: APjAAAUq5JRbDA39cQySF3ZRVrzEf0OSAy5MxNiX7LphDyTBj/w/FPxd
        Y1qsYPU0u3hW3CrEQdVumbUpOw==
X-Google-Smtp-Source: APXvYqxLEe3KL2Zldw+TrHLk4DNNJbwDIIiCfEsGQS+VUTgBS6MuEFSHCE9qrdN1ThzKlXUAaqFniA==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr9371388pjh.101.1574200029396;
        Tue, 19 Nov 2019 13:47:09 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y8sm25901244pfl.8.2019.11.19.13.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 13:47:08 -0800 (PST)
Message-ID: <5dd462dc.1c69fb81.b84c3.e950@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4b63daf69f7b49ce8304b5cd85e39b22@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-2-git-send-email-eberman@codeaurora.org> <5dcf345b.1c69fb81.df1ea.f7f6@mx.google.com> <4b63daf69f7b49ce8304b5cd85e39b22@codeaurora.org>
Subject: Re: [PATCH v2 01/18] firmware: qcom_scm: Rename macros and structures
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     eberman@codeaurora.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 13:47:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting eberman@codeaurora.org (2019-11-15 17:19:13)
> On 2019-11-15 15:27, Stephen Boyd wrote:
> > ... to here I don't understand why any of it needs to change. It looks
> > like a bunch of churn and it conflates qcom SCM calls with SMCCC which
> > is not desirable. Those two concepts are different.
>=20
> I can see the confusion. The goal with this patch is to make it more=20
> clear which
> macros and structures are for SCM interface from those which deal with=20
> the
> implementation of how an SCM call is implemented with the smc=20
> instruction. It's
> not presently clear that struct qcom_scm_response (for instance) is only
> relevant in the context of legacy convention.
>=20
> I choose the name "legacy" since only older firmwares use it and having
> "scm_buffer_get_command_buffer" seems even more confusing to me! "SMCCC" =

> was
> chosen for lack of a better name.
>=20
> Additionally, the concern with having qcom_scm_ prefix on these=20
> functions
> (especially legacy_get_*_buffer()) is you get long function names which=20
> didn't
> seem desirable. If the long names are preferable, I can update series=20
> with the
> longer form of the names.
>=20

This is the hardest problem in computer science. Figuring out a name.
;-)

Maybe call it scm_buffer_*? Because it _is_ scm communication with
shared buffers? The newer calling convention passes arguments in
registers, but the original calling convention passed a buffer around
from non-secure to secure world and then back again and had a embryonic
register based calling convention. That buffer passing still sort of
happens with the new style but it isn't done unless the register count
is larger than 5 or so and the return buffer isn't unbounded in size
like it was done. It also sort of follows the ARM SMC Calling Convection
spec now.

