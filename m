Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E6C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1579921D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KXOcnmAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfIYPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:33:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34483 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfIYPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:33:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id p10so3513869edq.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXF8fOz68zu8jSsi2oLIZNjcKNSoQ5Q7ICUWMBhW7DM=;
        b=KXOcnmAsWS7K5fEokrmP6H6YvWriFRE43bTxIzPEcqbKvG3i6jP0yrnKae9CayrOhi
         OgnfAzse2GCck6ihKQ7DiJ7/vLOQj94ZveFNjE4frgxVKGQFgofEJoOKQBdbKKfaHxoo
         9CwuReM6ZALL4+5Dq+YY/QQkeAQPNsZcrsnHWIlG8Zt9Omv48XePZvcZWdWlrt2MmpMo
         zSQVkgcrK/e5W6qb3z176HRO6DsOrQvb6HtQA2ik2ojmaZixvYMsfSWPZO5fEQc0Knll
         +Lgq3/kv0tXMsD1PgbyombFdVFAR3CD+7sPL1tMWb/L6rvIC/AYrdPChjVCGn9AB7Vz6
         JeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXF8fOz68zu8jSsi2oLIZNjcKNSoQ5Q7ICUWMBhW7DM=;
        b=qAkwzYMf8XFbszbj8La+RLcFiZoYPpB99Eh/ebA5VCM8zSUwezIYe857PgeW4JICxS
         w0fxyMfUoZzipoyvLFKIQh82lkErh6UviTOPjKQ4URp1VPH7Lq7uPppipyX1T0/bQyvw
         gjSYcHJVDFpPnGG0d2XQ7D2Cki/P0LfcbycXXIMicSWywhYnrQ6IGTdEUAf8WuESx3Sv
         pF+Botra2mOT6c180pKk877LoTEzEOdzCK1b7PFBuQl00BF6cumVE0+Xk2ccDiL6CdJ6
         kEiogtH4HwzDcqFMJa1TGY5uDYtS/dMeMuB0h/gFScm2dxRP4wYkrKwYzLaeOYbNPFb3
         Ab1w==
X-Gm-Message-State: APjAAAXdtJdKQta+EqVhZXsZ609L7VVHS26le9ohtF+TLhoToHh0xrCL
        W7F0wdXlu1/O9s6ge52ICRbe7tliI5PWqQarRMMn1g==
X-Google-Smtp-Source: APXvYqyGv4FmC6yYf2LhgfcVajwLZ02PBJ7HwqmwJN05DKTE16YVRBPpXj+65ZSYdB/rcZEXAdp1TmOk3mAGX4b5NdM=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr4793502ejg.286.1569425613175;
 Wed, 25 Sep 2019 08:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
 <20190923203427.294286-14-pasha.tatashin@soleen.com> <20190925060533.GB30921@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190925060533.GB30921@dhcp-128-65.nay.redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 25 Sep 2019 11:33:22 -0400
Message-ID: <CA+CK2bCqFwC8hADny5svR=Jj7=js05gXV=Rz1L7ZTfEDmBBRBA@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] kexec: add machine_kexec_post_load()
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Acked-by: Dave Young <dyoung@redhat.com>

Thank you,
Pasha
