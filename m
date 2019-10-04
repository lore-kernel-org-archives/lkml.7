Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D67EC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F81F21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsIt9NAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfJDH1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:27:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727548AbfJDH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570174033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=XUCVhLyFU0egbeCCPyi0gdOMvXkRkhtQ2UQBx6VdaxY=;
        b=IsIt9NAQW1emN3o31/e9G7Q0L6ElHcLkNQNEF43Buh4YusBLfeIinADVCsYky2Ck6vWrNR
        ZTcG2DeNLY5dMiFZpeTJ5p0hdOG/2mi9e8Yj3dG+zNlMFhWvJawz02D2ZXnd0y5BlgcD++
        oCHWc6SQ5shLa4NDXwhJlyoqnE69YgU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-nHXjp5z7NEOTyBm-S4o1ww-1; Fri, 04 Oct 2019 03:27:12 -0400
Received: by mail-wr1-f70.google.com with SMTP id i14so406800wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 00:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aEdY8z5AWfJTa7GTLm63bwyTFqdMFQ7x24M2Gp/SY3g=;
        b=Ka45DmVYia+Kx64IfgbQdKB/0x6mALWoJ0vMYzHZj1ghUqOlqI4/p96l6LPS5My7/U
         CRI1WdlR5qAbk6xqoy0E/F7+Itw7YyHIUMBlFN/AzkQll6tQHKrv9ossTKa1n+Zc0t5J
         4Nn+EQRa8a0U+L7tPBFeLqGdVrcsaP7GTbtKFnGLCa24fq7TNuucZLSkF9frAcI0kInf
         avvrSzmUUMThEbRBQJPTIYuLDdM05Bt9jUPJgvtIvXdYeyhZKZhWmtQVVy8fMHvcm7Pj
         0hjLVWfHHV52FsLxE3PvkgJWEJeakjeSup3Nu+84FjzX3BbXO9M/qN7zexSBMqtO5hjS
         nquA==
X-Gm-Message-State: APjAAAVLSbp+hlbkMgTx6Gr85WHbXtKrOqZ0Hhfw2ziWL0oRwbxMkwHR
        nVlgmbBZuhd0TG0EjclXMi0sl7tdXByOJaVHN4pZIhUFwQ6i7WEfFR34zPeSNOPt9l8b1wwPK0t
        GK2EI8+T3NiPyOQIQ2MiDzp9m
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr1474590wrp.10.1570174030814;
        Fri, 04 Oct 2019 00:27:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVRPZN9h/0C4acuqjoYLiCq8cberKuvezxJ5ZluiUcxk7RleMGP3eYODMaMTDsSPJdw/GkUg==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr1474556wrp.10.1570174030564;
        Fri, 04 Oct 2019 00:27:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e56d:fbdf:8b79:c79c? ([2001:b07:6468:f312:e56d:fbdf:8b79:c79c])
        by smtp.gmail.com with ESMTPSA id m16sm3817660wml.11.2019.10.04.00.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 00:27:09 -0700 (PDT)
Subject: Re: [RFC PATCH 03/13] kvm: Add XO memslot type
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        luto@kernel.org, peterz@infradead.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, deneen.t.dock@intel.com,
        Yu Zhang <yu.c.zhang@linux.intel.com>
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
 <20191003212400.31130-4-rick.p.edgecombe@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5201724e-bded-1af1-7f46-0f3e1763c797@redhat.com>
Date:   Fri, 4 Oct 2019 09:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003212400.31130-4-rick.p.edgecombe@intel.com>
Content-Language: en-US
X-MC-Unique: nHXjp5z7NEOTyBm-S4o1ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 23:23, Rick Edgecombe wrote:
> Add XO memslot type to create execute-only guest physical memory based on
> the RO memslot. Like the RO memslot, disallow changing the memslot type
> to/from XO.
>=20
> In the EPT case ACC_USER_MASK represents the readable bit, so add the
> ability for set_spte() to unset this.
>=20
> This is based in part on a patch by Yu Zhang.
>=20
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Instead of this, why not check the exit qualification gpa and, if it has
the XO bit set, mask away both the XO bit and the R bit?  It can be done
unconditionally for all memslots.  This should require no change to
userspace.

Paolo

