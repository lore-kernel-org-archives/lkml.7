Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A668EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7376C21848
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZMPE7XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfJDHeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:34:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36162 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727326AbfJDHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570174463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=OcXZK/E6XChoGriXNHisT5XgSISsNlmPOggtOuvsig4=;
        b=OZMPE7XDnF1oYeVDsjylnhS31zfRntw9toYKAdv4jM/U9tEg5On5SnTTBmwMM0nGhPkymU
        b+nIHZK2IPBmtnSw9gHMLU1iEAaPqTjgR6S7PhklBuHB2WzmJBUcwMW9u01VeMHUoAE2c/
        1+bu0YbLidVFcLjyD2X65uubVw9JAGA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-AbvdHZX4OjKn_Tum4vfsUw-1; Fri, 04 Oct 2019 03:34:22 -0400
Received: by mail-wm1-f70.google.com with SMTP id 4so1257782wmj.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 00:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDtbjvAly1a3qucQKzKApj2XOLHI9VDInqQWVwE047w=;
        b=duyK5ResQSaFDMassz/Qxlv+rv82BaW5naEW2K8IUgz88vfiDBR0n31qWwYHXLp2VP
         rKmV0Lk3XAjABUNckp9dxSO6I2X4GFeyC9/g6fMdUh43YyE4iVgVv42w52yPKJ3WaARt
         ARwFvQ1YMLPwVSFAXeqkVEB/Hes8NgCKb6vX1ePnKBYoYF6rMgwsMp4FhVpKdGpepx9I
         v+4wRfVSa/KmAuR7PgFhNzUmswf2j8XVnORblEuMGg0CAoqZnEGw156u4zBsbYnld0Rm
         kxRgBigtWpjlH+g+e1oHPXOQkcu5dE8LojDoSZIvLmoUUFTTfrdjpGrVlpXbf2I9rhbX
         2XAA==
X-Gm-Message-State: APjAAAUIqDTzDV5I45VYaKXhveOsJl6lqjYrE9VRLTFLLzTh8dyhss4+
        RiIIr/XTJ7nzacswi2NJ4BbpS6ZxkA8bggueeT1vFuVypCuPe/mrHa2Kmcv1F+FuJHnQrGXyC1R
        rUY6lRSTP63i4ee9vQ80P3o9w
X-Received: by 2002:adf:fb11:: with SMTP id c17mr10972927wrr.0.1570174460812;
        Fri, 04 Oct 2019 00:34:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvQcgmyGS3G8q5MATkz1wmCFy63G+ea3phQ5+0hoNe8HjX26XKtAwtyxuWOXLFyvJErOCKQA==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr10972907wrr.0.1570174460541;
        Fri, 04 Oct 2019 00:34:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e56d:fbdf:8b79:c79c? ([2001:b07:6468:f312:e56d:fbdf:8b79:c79c])
        by smtp.gmail.com with ESMTPSA id a7sm10244208wra.43.2019.10.04.00.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 00:34:20 -0700 (PDT)
Subject: Re: [RFC PATCH 12/13] mmap: Add XO support for KVM XO
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        luto@kernel.org, peterz@infradead.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, deneen.t.dock@intel.com
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
 <20191003212400.31130-13-rick.p.edgecombe@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a0ea3b34-2131-3fd5-3842-ae3f98edf8d8@redhat.com>
Date:   Fri, 4 Oct 2019 09:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003212400.31130-13-rick.p.edgecombe@intel.com>
Content-Language: en-US
X-MC-Unique: AbvdHZX4OjKn_Tum4vfsUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 23:23, Rick Edgecombe wrote:
> +
> +=09protection_map[4] =3D PAGE_EXECONLY;
> +=09protection_map[12] =3D PAGE_EXECONLY;

Can you add #defines for the bits in protection_map?  Also perhaps you
can replace the p_xo/p_xr/s_xo/s_xr checks with just with "if
(pgtable_kvmxo_enabled()".

Paolo

> +=09/* Prefer non-pkey XO capability if available, to save a pkey */
> +
> +=09if (flags & MAP_PRIVATE && (p_xo !=3D p_xr))
> +=09=09return 0;
> +
> +=09if (flags & MAP_SHARED && (s_xo !=3D s_xr))
> +=09=09return 0;
>
> +=09pkey =3D execute_only_pkey(current->mm);
> +=09if (pkey < 0)

