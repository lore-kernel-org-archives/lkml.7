Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6427E2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JHoUOo20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLMXLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:11:19 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41480 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:11:18 -0500
Received: by mail-qk1-f180.google.com with SMTP id l124so604032qkf.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ej/qAZBSr6NQ77IrGs2L5rthjaD3OKf9wUGrXR2R3yQ=;
        b=JHoUOo20+BKAuo3SzAXPD6L11pYowHqduZ3bk37Q/sY/e5JkIY/HXw0rULLdkFVfrz
         ElxQcEaNT/Y17uC4YiCTpzIzGeliIuj5hZwQL9zyNMtnA/M4RAEIey6tcseRuh0maby6
         ewQDsbptrKdrcKMZ/e2x/ZOhu6tH4GR/c0/zvB+t7Rqg/lVtewrEOdsyvRKgJajO8cTw
         8MOmS/b3x1+2jBx3Yin8BT/R4/3EZ6n1mQyNAVOKWDzNKA2x3zFx+u3msG5dwf2Jv7Sr
         EathoKfJOpqHDQLf1NKlblv/MBVGKCOnk7JNCkOG7CiKoohlFe8r61SNSivUDRkILLxB
         83FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ej/qAZBSr6NQ77IrGs2L5rthjaD3OKf9wUGrXR2R3yQ=;
        b=XWdYQnd9Xvmm+suCF8f9Eah5bBq5pFJAMV+RhESNc6nY9afGFmH0uyzjAhjGAEU0Pw
         bcZMZCFFm8yJutXkjJFSFqNYBKriFRW0uSSHdLY7Qz56Cp6QaYsLSTGSJ/khZHTDS51A
         kXi7mtVbANxf1/r3ENGj3LLi/+VRIGy4XioGlWr+eZI2tLQXAEdcjFHUFhObfzv+0BJS
         FIWHUCNMvlofB2ZtXQwoiQrNyShQVgE0ZCVC6+canDHE1zYsC0SqmOH6LONF6DOQRpP8
         iqmZHkfNLFycdaYIUT3NzVjkg+qS6TmbeNNz0Utoh0OQBcTOlJG8ZYBphNFfAsMclVmo
         R3DQ==
X-Gm-Message-State: APjAAAV7aZ2KpGdxd3KV8hUyBgVvlOZHjvKTMKMiZ+30SPGj3esKTthT
        vbHyBy60jRQd8ax79E4eIdm1VasSdVA=
X-Google-Smtp-Source: APXvYqx+G6/SIZn77gZIHKi7EvT9I0S93illSNqw45DT3vElev9VkgOkgSzyyn0+vw7ohoTMkOKiEA==
X-Received: by 2002:a37:2f47:: with SMTP id v68mr16236849qkh.217.1576278677753;
        Fri, 13 Dec 2019 15:11:17 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g4sm881579qtg.35.2019.12.13.15.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:11:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: "rcu: React to callback overload by aggressively seeking quiescent states" hangs on boot
Date:   Fri, 13 Dec 2019 18:11:16 -0500
Message-Id: <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
References: <20191213224646.GH2889@paulmck-ThinkPad-P72>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20191213224646.GH2889@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 13, 2019, at 5:46 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> I am running this on a number of x86 systems, but will try it on a

The config to reproduce includes several debugging options that might requir=
ed to recreate.

> wider variety.  If I cannot reproduce it, would you be willing to
> run diagnostics?

Yes.

>=20
> Just to double-check...  Are you running rcutorture built into the kernel?=

> (My guess is "no", but figured that I should ask.)

No as you can see from the config I linked in the original email.=
