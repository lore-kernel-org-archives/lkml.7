Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A81AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF4E20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gHpgVYE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKOA0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:26:24 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:41690 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:26:23 -0500
Received: by mail-qt1-f172.google.com with SMTP id o3so8929385qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0tFAznP/o2VP74kg2CnbkybxNqllPHihT5bPzStJDZw=;
        b=gHpgVYE7BklA5dff+/FV7O0g+fRSURY17JLB+bDgYYI/ULYrMLGXLVtkDm3WaUmTzW
         3BJWsOf0KeIsLbFLz7WeJMYhF3EoWf2p5sGlaWaImptYaHx+nD/npZxIZ2bbxnuB9/Q7
         VnVasKuq9iGMAPrU2lcqF4mtbvEuwO4uOQ7wC5WEeh7f8fbVwVCpPdvFAt5SG9Ve9wPz
         6AGaX5Y17XDcMMX+gVtHiXtYgWY3eTueQ7KH+hbbz/pYkaf7+9vKm5LZLloba606odtZ
         bQY1BV7qU/IkcjkJ22KjAK66OwybBtbHJukxQ4pH6mbHCY7ywayi02S7CbKQ981R0aTM
         Vh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0tFAznP/o2VP74kg2CnbkybxNqllPHihT5bPzStJDZw=;
        b=Vx49o5nTC8hehjcebacju/Omxf/35aTjpOe+gOZdOG70mpj3nrctB49AXhxmKvnXit
         3FxkCinBQLTskuo8RN9WBjF89ZKDBLtrL75GvK48so6uHaBjiC2Gr02rnPiSeMhuooqY
         HAREeurYzBEUm2TODDYOq6RwSJdAulVJoBF1y+RXPLOsCdKG3WCw6GgvQ0qty0XPHiOC
         XpfEahhNH0mZ05AwHyT78Wn7c/OdjUMwTvLg66wyH1MVAx4OuxUZZEwD1rxnAiELVrYW
         qLhtV4vVZHONpOJvtCCDURvy1M0ea++3Fjzpeaui1XAz2T9SvqG8uL69pLjz8JINjoDd
         QCyA==
X-Gm-Message-State: APjAAAVZ6drwwA8D6nK4Y3wVzQFP2MYdk+P11HiU7PJLcgs51VZ0LCnb
        REK+6euEMtsNeSQWNkwCPw8Y5A==
X-Google-Smtp-Source: APXvYqyPWcdxmbDJkLh4PF4RYWC5w7LaBpYgd9hxKsutZWpQWgJEpJsKfIh6RuJQ4NDIuohgyYqCpA==
X-Received: by 2002:aed:3fc4:: with SMTP id w4mr11497978qth.120.1573777582450;
        Thu, 14 Nov 2019 16:26:22 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q8sm4302888qta.31.2019.11.14.16.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 16:26:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Date:   Thu, 14 Nov 2019 19:26:21 -0500
Message-Id: <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
In-Reply-To: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Acked-by: Tejun Heo <tj@kernel.org>

Tejun, suppose you will take this patch via your tree together with the seri=
es or should I Cc Andrew who normally handle this file?=
