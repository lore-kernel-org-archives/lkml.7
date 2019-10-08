Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE6C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A51D21835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IUn06mpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfJHJcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:32:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46262 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfJHJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:32:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so15955677qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=EWJqqy29yofdCquZBPthLER+Jv293+BzSZVb1kweNlE=;
        b=IUn06mpS2xz7vLSozYS3LnEtGuT0KW+oZs4uibzwSg/3iNgPs9KOIeGn7NQK8fYDh7
         BnHO22WND/EsUUAyk7hGQY0w92oRpeiX21uNyO0lCj/9StMJBNCkYum35KnmCUGPl5gt
         xi7jfmlpw9phFZyg4Ah8bxW2Krr53lopuINKHylwf2xNyN8HDTT2lRBX/X/S13MRbAe9
         Cl+1RvM4DNB9xzTrxWo3TQfIQ9DF1JClzmwVETc/AjoAVqfW+NJS6oOqlL0Em4+qYYa7
         a2g49hQs7d4DVeRcQDWXC4Kaq3wFRKZGIDtUhI5VKBqpLBc48MjwmdLwAP2t5Z6Kvu68
         sf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EWJqqy29yofdCquZBPthLER+Jv293+BzSZVb1kweNlE=;
        b=OejVP2ti8egDicdOYYhZdpmi9jEzbriINqPKoz7m/5Su8ICtXhH+TCXAi//7pV/fNl
         Va/K+NG4NcvVliEhz7lPKT5j+1/jduM61XIWz9ZGQWClHPiK6OKjhXg7i9RXaVKmBhyE
         iiQqN8brohJtvX1wwU0xMv8PuNn5THzMd0YjO8mxkKYVzJrLnV/y3EfZNOTnLbgJS9lR
         RfrzxtMkrygCq/Ta2/JL2SwM38AySypO61j8JKhx8bl+Nz1c5sh4HZ4XXZI9wGLZRleO
         OgbN5mRtauWXqxrtv+4xfQjMKohoRL7uTKxp8aXy4eSfDJdOAKJa5suqiHOWcYpfc4od
         0eDw==
X-Gm-Message-State: APjAAAVQxYj6ayfhhpJhiLjaQGF2OnxIYrMB0iuslUkfde9BZ8s5k9LN
        CDoT8MiYepGLAV/7ZDCHIcmsS/y2IZ0k7g==
X-Google-Smtp-Source: APXvYqzu7RW2LzgCVPn1UYMRWg4Xv+vumYrColU+r4PBMhJWYci7G8NPsGRGFKpRPd3VwivsJ+cohQ==
X-Received: by 2002:a37:b302:: with SMTP id c2mr28515793qkf.442.1570527136679;
        Tue, 08 Oct 2019 02:32:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d134sm8272302qkg.133.2019.10.08.02.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 02:32:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Date:   Tue, 8 Oct 2019 05:32:15 -0400
Message-Id: <43AC5AD1-377D-447C-A703-7F10423E6FA0@lca.pw>
References: <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
To:     Petr Mladek <pmladek@suse.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 8, 2019, at 4:15 AM, Petr Mladek <pmladek@suse.com> wrote:
>=20
> I am curious about CPU2. Does scheduler need to allocate memory?

It happens before with debug objects. It might not 100% necessary but it cou=
ld easily end up with this way in the current code. Moreover, this is just a=
n example of how things could go wrong as it could happen for pi_lock or any=
 other unknown downstream locks which are not really console related.=
