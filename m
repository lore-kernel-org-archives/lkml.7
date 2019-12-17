Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A12CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0BD2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Zg/g4sKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLQBwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:52:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35341 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfLQBwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:52:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so4005295qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 17:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VVyljFYvcymdWCFK/BttoIqrDbX+SNPTmTVvMoaS1rc=;
        b=Zg/g4sKxrShJQPXDzs8HDRW8YlgUrvsTibiQNkDioCdFslJvaJsftDgwZSScLzBoVz
         vv4Uc1S6vG8jZXIeC7VMU6iPWHnpyjXY0+wJ7/A1xZlwnSYJkdX6Az2KpUePN4mXFcGD
         HplBwEOpJSiPHC3Sv3mSqcGinzb/Gu326DVyFiAwdPWNKkjvYsTXCbfbdlJgieRIrdXG
         H6MyA4PPj6VmQQCZ1EZM++fi7Nxz88pRV9SojH+Vp90ISnTLyk8368rKdeDKesA6TzBT
         0+Iy9P8uGFVCeW/Q1OBgcfZQAP/BBflR7kOZJvB4QyzLywINSbkBYkCFOTdjVmCk9U23
         cj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VVyljFYvcymdWCFK/BttoIqrDbX+SNPTmTVvMoaS1rc=;
        b=mXSJ1As/8Wxa1qFlSEtOiJj0IHyF5djy5suh1xpz/RTQCxXwbzJvQFtCzRcwA6NeCB
         TpilGO8MQeMSkLtI/21ItP1InKRZu2OpSc5UAAgNubq7rwrNEvidEr7xgQnALiQczwre
         KdDW+Ab0kGZjT8d71YdNT5ACAJL+1fjTVtoVtb/Qz05tJV4o8rlHpw4AYDygdhGk8ak1
         UJC80nyJWZPBnzViNHdu7Jq8KJgrdAmJaN01/Mi9r3H2BFIxsvWRFS8qSOsZs/TZmqIW
         WV85j40tAfqqoMY6hxHzTfL1MzrEE8fqKsIq+N0g4ZYat+PhF8XNSWHhBUi2Gx6NFqOt
         FNRg==
X-Gm-Message-State: APjAAAVeDOZ2ywoG+kytHPRQuUfYY+Eb+01oeoSTD5jsQ3EdtOopIi0Z
        J94V8e0MOWM/SGWFSHTUU4JlzQ==
X-Google-Smtp-Source: APXvYqw7J/dHExe28smm7mZd9XhG1WSjUmpefrFPr1IqCbyGGLmlwbVphL2rCumhhBkfSfgbjKlx+g==
X-Received: by 2002:a37:7b84:: with SMTP id w126mr2644733qkc.280.1576547532672;
        Mon, 16 Dec 2019 17:52:12 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e2sm6551540qkl.3.2019.12.16.17.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 17:52:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
Date:   Mon, 16 Dec 2019 20:52:10 -0500
Message-Id: <4F9E9335-334B-4600-8BC3-4AF91510D113@lca.pw>
References: <20191205010055.GO93017@google.com>
Cc:     tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>,
        gregkh@linuxfoundation.org, pmladek@suse.com, rostedt@goodmis.org,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        dan.j.williams@intel.com, peterz@infradead.org, longman@redhat.com,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191205010055.GO93017@google.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 4, 2019, at 8:00 PM, Sergey Senozhatsky <sergey.senozhatsky.work@gm=
ail.com> wrote:
>=20
> A 'Reviewed-by' will suffice.
>=20
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Ted, could you take a look at this trivial patch?=
