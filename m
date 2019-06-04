Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383372081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sd9yR5er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfFDP4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:56:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41276 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfFDP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:56:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id x25so1129563eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzHc9NWWKRgZbxCuCESuOAVy6V5aZPy4lPNt/yymc90=;
        b=sd9yR5ermmISTJa8qycY9JqtqdzXZe7wb4kFIdqHQtc+MxalnsidgCTphkzIMQyWJ/
         zKu8gVFayK54GS8JR4aQjeG52V1VTes9JZbEC/tHjwYE9gBsWVeKYGvtKZnzpES6GFih
         gpHa10GhBbAFOjaIa9ZYiEW5WEHkG7nat4M1a13fqS758WSTOPuTnSWHPpSLh/rBKmuJ
         vSfWoCHLpQTQA+TRQM/VlMF+t6hYxnfT9flxonlslP3mZlarerDm/p6kK2/YknOpGtYj
         8wOaqdcTHpz8NmMs1UT7YW0vMFdEZqQmCQULrLKlsCOzxL7SzQG6o1u1YxN8i2DsY+fP
         R/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzHc9NWWKRgZbxCuCESuOAVy6V5aZPy4lPNt/yymc90=;
        b=NV95+nC4eBpVXmT8oeITcqBCpP6Esadgqk8arWuu1RNSiMeDm+vrMEjXtXLf6K38af
         0gnWoFDjCSfhvY0aL88piBLg3dWDt9Vemi9oDFQt9yVBpdN9HXqaIPmvYMzYxgI93WTX
         W4OS6MU062roMwvcDWs0HAzursmYsMFK7yxJJS1pLIMBwtxKB10ZZcuwKOW1KjzU+faG
         /pZ4dhS8adHlZSkuzdWFsz7cXZVyM2hQ/cC/lI531wvwm2d6FmK29ziAoPXSp1zBCzLC
         LE+DF8Opsa1v18E/fAJhwRveK7WoQt+XM16Pw04K3PdRLNtS/ZNxKbFAngCGGu+m4DsD
         PM/A==
X-Gm-Message-State: APjAAAUuPGfkS8y1vebm7rGJkKcDHlRplZ7sAHk/1/5GB0Mjy/jL8fyu
        V7/+D453K2/RZ9k93NaHDQlv8PDqSer4vc5BJpF6JQ==
X-Google-Smtp-Source: APXvYqy1u46ubz0u45ue4qkdyYoU6cHzImoFzlcN2RkZi9UssmAtBLX+xmNlW6sctB99uOkmThPjz1ekEyf8hgSWqgo=
X-Received: by 2002:aa7:c391:: with SMTP id k17mr37200588edq.166.1559663807555;
 Tue, 04 Jun 2019 08:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
 <5CEC9667.30100@intel.com> <CAOyeoRWhfyuuYdguE6Wrzd7GOdow9qRE4MZ4OKkMc5cdhDT53g@mail.gmail.com>
 <5CEE3AC4.3020904@intel.com> <CAOyeoRW85jV=TW_xwSj0ZYwPj_L+G9wu+QPGEF3nBmPbWGX4_g@mail.gmail.com>
 <5CF07D37.9090805@intel.com> <CAOyeoRXWQaVYZSVL_LTTdAwJOEr+eCzhp1=_JcOX3i6_CJiD_g@mail.gmail.com>
 <5CF2599B.3030001@intel.com> <CAOyeoRWuHyhoy6NB=O+ekQMhBFngozKoanWzArxgBk4DH2hdtg@mail.gmail.com>
 <5CF5F6AE.90706@intel.com>
In-Reply-To: <5CF5F6AE.90706@intel.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Tue, 4 Jun 2019 08:56:36 -0700
Message-ID: <CAOyeoRW5wx0F=9B24h29KkhUrbaORXVSoJufb4d-XzKiAsz+NQ@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: PMU Whitelist
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 9:37 PM Wei Wang <wei.w.wang@intel.com> wrote:

> So, I'm not sure if "quantifying LLC contention" has been proved to
> be a real issue. If this is considered to be an issue:
>
> - without PMU, we could also write a piece of software to run in the
> guest to quantify that contention (e.g. by analyzing the memory access
> latency). How do you prevent this?
>
> - the same thing could also happen with the L1 cache (e.g. a vCPU
> and a host thread run 2 logical CPUs on the same core). If this is disabled
> as well, we may have very few events usable, and would like to see what you
> have on the whitelist.

Right - I'm aware there are other ways of detecting this - it's still
a class of events that some people don't want to surface. I'll ask if
there are any better examples.

Eric
