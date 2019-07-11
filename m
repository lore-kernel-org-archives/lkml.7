Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F1C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5A821019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Y9bC61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfGKJxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:53:04 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39876 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfGKJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:53:04 -0400
Received: by mail-pl1-f176.google.com with SMTP id b7so2754363pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=6NtT6DZ7mBm/hq/33Gk2DQ42P0ZV+m78SQV6jVayLo8=;
        b=Z2Y9bC61KNVqyZKEhedmB5wwt4BD/sH6nP68A2fdBC05YFOlOPgvObOfNMhx87D0mV
         NXqLmNH0r4NdnSRf0VlgVQHSe5wiAtYwIFPUWEYSHT7xccDkxM4D4xMgLd/k3RI+glcV
         fgUlxNimfcOH+iJtp3bccl3mzx/N44IzqAcWN+QaPfETpYbucW9IwitcwsXVzJ3M5vlv
         0W5RaNBNSzTsokzHGxQH08p31GqJJM7sZGqRMx4td2iF475UNCFVMm3L9OPU7+01KS4Z
         siYaFh01HaplwBThr9IQkVYt5XbM5TjnZOfgm/WNY4DwXV+Jnfb1A68f5Ak4RB+kbkur
         /ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=6NtT6DZ7mBm/hq/33Gk2DQ42P0ZV+m78SQV6jVayLo8=;
        b=XeTMaCZzA+cn+QV6xtSFZ0o2fhhVpRrIbVCyrj8UgcUKfweEIHE3GJn0yaXDGruaQ5
         7NZ8b19QoOV4qN/i1ayb/spF0P87e2XFiH5L3aoh7sfQkS06vTFA3wndjKrF7DKYfkoS
         1Jtf4b1xCRSryaN1PpsPJDG5RTgBk8V/INtyQoGDIcZvuaJztsWG4oxBq27cD+Qmu6To
         EQu0vjR9+oYNCqgBT3Jf1oVY/cQruindeziUyNIfqsC0Do0hD4c+eopf1SpSLqeBY1+v
         K3uCmuxNlmgAYkg14wi3n1IDLYa9J5cMCrYg8dcihfO6NGY+lgmzO0hhgY7M3/SbiPok
         Plrw==
X-Gm-Message-State: APjAAAXXhfJwJwV8svttcLmgqcvFbNFauaZ+Eozxhg9fJhcRlx844CB9
        41yHkheISh5wjMTT8x4tO+BXQNv+
X-Google-Smtp-Source: APXvYqxwj8f3cqPOLxu+gRyG5fvLWKETGlbpKXGYJFLFIGvk8Xz3Dgr/RmnZ4HUIN6hy+IAAZYpkoQ==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr3687188pls.9.1562838783694;
        Thu, 11 Jul 2019 02:53:03 -0700 (PDT)
Received: from localhost (193-116-118-149.tpgi.com.au. [193.116.118.149])
        by smtp.gmail.com with ESMTPSA id 131sm7518856pfx.57.2019.07.11.02.53.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 02:53:02 -0700 (PDT)
Date:   Thu, 11 Jul 2019 19:50:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v5 3/6] powerpc/memcpy: Add memcpy_mcsafe for pmem
To:     linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Santosh Sivaraj <santosh@fossix.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190709121524.18762-1-santosh@fossix.org>
        <20190709121524.18762-4-santosh@fossix.org>
In-Reply-To: <20190709121524.18762-4-santosh@fossix.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1562838505.oes5qb0f1o.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh Sivaraj's on July 9, 2019 10:15 pm:
> From: Balbir Singh <bsingharora@gmail.com>
>=20
> The pmem infrastructure uses memcpy_mcsafe in the pmem layer so as to
> convert machine check exceptions into a return value on failure in case
> a machine check exception is encountered during the memcpy. The return
> value is the number of bytes remaining to be copied.
>=20
> This patch largely borrows from the copyuser_power7 logic and does not ad=
d
> the VMX optimizations, largely to keep the patch simple. If needed those
> optimizations can be folded in.

Shouldn't this patch go after the exception table stuff now if you
squashed them together?

Thanks,
Nick
=
