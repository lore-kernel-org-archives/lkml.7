Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD2C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAEF20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYLwGxL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfETHBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:01:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46302 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETHBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:01:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so6247377pls.13;
        Mon, 20 May 2019 00:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=08DG43aOD+Euaff1im+598ddGTX4txkr6BAgSvzzebg=;
        b=lYLwGxL3wK2u4wZzmtQ37p/dK5KP31YOg+9GaIBPjcXpzSKOvrN0rUCR6eJ5ammzSj
         nCsA4dCKFmP64zrGVCk4PkF7w5usqGCROsUGpEZbd1F788v7n1N2GefY0kOTMpHt7Hyt
         4G8CQGeHMGeXi1C6OGpo9vIh73RK3KAqRQSiINaIft9hRrRLSLaFr0kQFwdTMS5/e2R/
         iAQZkSXK64YEgRVVqevqYZa8F/EW2Vkw+0B//9D+T3Cf0C75/ey05tdQdtodOFj7Ol/s
         ihBQ+ZOI3OoxCEVWWkZf41FeiCGJvRbGp3w1ssCe+2nDUjmgT/xXKPkSmz9nO+fFhpLe
         FhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=08DG43aOD+Euaff1im+598ddGTX4txkr6BAgSvzzebg=;
        b=mXMoKn81cxf7Tr0HelpZSYoLJ1LSkNJG77SuCabYf8Uh6m/ETaz0SkushqWPPx0r7Z
         FxPXclLACHZtKSpah+V1mzpATMIa6qz/ZLryM1kRT1JM5UZ++6CXCPFG0I5zuS14Rqtn
         Jmj6Fna8xGApYBF9vv0oAud8hSUwIHoB/EqJiqYGbvGq4kWqeLgNuFYCfMzPwGE8QK1N
         /yESG6FIA6QTLNP3oClGEY+T1zY/E++9S8ZMaNmEP9PiYIEK36hAIiISbnx8LLOAXYXU
         Ey44H61Zo8LGg1E6UOKxk1sUqpuLI2/4OTnHuyuXt3wsIL6x79nslXqa/RliTmpjUAcb
         cTww==
X-Gm-Message-State: APjAAAVi6OnV6XrdlYKFt8UbOxMGbLDp36s0gmisDsRUtloa/Tnrlq7B
        UUFf+D3nzPe4JSxykWY06xY=
X-Google-Smtp-Source: APXvYqyZ9yhaosf5utP1M5IvBH9z10LRioY4qvrROs5RLMZ+ssuniXnSj2koK4Tlw+OmDnuU9ok4+w==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr73024563plr.245.1558335680631;
        Mon, 20 May 2019 00:01:20 -0700 (PDT)
Received: from localhost (193-116-79-244.tpgi.com.au. [193.116.79.244])
        by smtp.gmail.com with ESMTPSA id x28sm17981692pfo.78.2019.05.20.00.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 00:01:20 -0700 (PDT)
Date:   Mon, 20 May 2019 17:00:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: PROBLEM: Power9: kernel oops on memory hotunplug from ppc64le
 guest
To:     bharata@linux.ibm.com
Cc:     aneesh.kumar@linux.ibm.com, bharata@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        srikanth <sraithal@linux.vnet.ibm.com>
References: <16a7a635-c592-27e2-75b4-d02071833278@linux.vnet.ibm.com>
        <20190518141434.GA22939@in.ibm.com>
        <878sv1993k.fsf@concordia.ellerman.id.au>
        <20190520042533.GB22939@in.ibm.com>
        <1558327521.633yjtl8ki.astroid@bobo.none>
        <20190520055622.GC22939@in.ibm.com>
In-Reply-To: <20190520055622.GC22939@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1558335484.9inx69a7ea.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao's on May 20, 2019 3:56 pm:
> On Mon, May 20, 2019 at 02:48:35PM +1000, Nicholas Piggin wrote:
>> >> > git bisect points to
>> >> >
>> >> > commit 4231aba000f5a4583dd9f67057aadb68c3eca99d
>> >> > Author: Nicholas Piggin <npiggin@gmail.com>
>> >> > Date:   Fri Jul 27 21:48:17 2018 +1000
>> >> >
>> >> >     powerpc/64s: Fix page table fragment refcount race vs speculati=
ve references
>> >> >
>> >> >     The page table fragment allocator uses the main page refcount r=
acily
>> >> >     with respect to speculative references. A customer observed a B=
UG due
>> >> >     to page table page refcount underflow in the fragment allocator=
. This
>> >> >     can be caused by the fragment allocator set_page_count stomping=
 on a
>> >> >     speculative reference, and then the speculative failure handler
>> >> >     decrements the new reference, and the underflow eventually pops=
 when
>> >> >     the page tables are freed.
>> >> >
>> >> >     Fix this by using a dedicated field in the struct page for the =
page
>> >> >     table fragment allocator.
>> >> >
>> >> >     Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory wastage"=
)
>> >> >     Cc: stable@vger.kernel.org # v3.10+
>> >>=20
>> >> That's the commit that added the BUG_ON(), so prior to that you won't
>> >> see the crash.
>> >=20
>> > Right, but the commit says it fixes page table page refcount underflow=
 by
>> > introducing a new field &page->pt_frag_refcount. Now we are hitting th=
e underflow
>> > for this pt_frag_refcount.
>>=20
>> The fixed underflow is caused by a bug (race on page count) that got=20
>> fixed by that patch. You are hitting a different underflow here. It's
>> not certain my patch caused it, I'm just trying to reproduce now.
>=20
> Ok.

Can't reproduce I'm afraid, tried adding and removing 8GB memory from a
4GB guest (via host adding / removing memory device), and it just works.

It's likely to be an edge case like an off by one or rounding error
that just happens to trigger in your config. Might be easiest if you
could test with a debug patch.

Thanks,
Nick

=
