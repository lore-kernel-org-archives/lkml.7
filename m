Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF19C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DD22068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zwge6x1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLCREk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:04:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726074AbfLCREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575392679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8DvubUvc77D7QCd7w64sRjJyRVQE6dAmn4FvsDL5hw=;
        b=Zwge6x1Cpd4kSfnN+vFCPy8cyr1lqsJ02b2KIJkVLr84j1ZgLOyOnibGSJJMrRxC890dYU
        z2OimvDujGGZTLHRTnkYhzihaCZHeCbNl+zsBMg7whHWU07Vr17IskH+afRj6iUFTU0YVP
        sobin6L0Okzt8P5fJlsGM+fRahtOrN4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-V9iWGWMKP_S6dOO2XsuMWg-1; Tue, 03 Dec 2019 12:04:35 -0500
Received: by mail-qv1-f72.google.com with SMTP id d12so2584978qvj.16
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwSc2v/NazflzpFrOlkNA8IEQZUbi7+GF+4oI30XE/w=;
        b=QMNASyYYycuU5HMCamWz2UHN312otsRY+VBTgl2r2SPz5mq68jyisecVJcHIMilRt5
         WaPYsxl7KLgriJoLLWKLciQgo96jI3D2dkAN10epZtCfym1gjwQMuSEw36GRW4iVtp3v
         czexs+RiJPDoco5LXu47Twvt719295vKehMnlawLcOho4HcbSlTGuxnCMiwgvP2LPeMN
         dlTHaVWu55VInIxkRVaZPwbv6EGvuitzC6/RXsXku94cdgcKRX2n80L8TGLV6abD4AY+
         dMPoQnpCUMpnOlKEP6R3/mSW/bXonDuZGXHCBEFkYM4z5Mzj+j4kfXU1Pmnd/TPOOx5O
         r11A==
X-Gm-Message-State: APjAAAXcCrfy6qsd5j1+HCAQD8V0exofS2yCEDkdjxTfEYFYpgBcNd3E
        ghOmMHur40pJYwmPTeWsHhS3lJb9lFfigWA6cQ+KB9flRiSESGggdy/IAELLTca8Z6+ZCQAQGT7
        7kvYqYiGtDJo9mM1noOsXY6A7
X-Received: by 2002:ae9:ed43:: with SMTP id c64mr5709437qkg.78.1575392675442;
        Tue, 03 Dec 2019 09:04:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxETwyoGLSM2JBWDT+YiR0hnGqeVSXHwTu0/n3KH8ZbAv41W1TPnYnRnlWUEQgCwYJO0Iavvw==
X-Received: by 2002:ae9:ed43:: with SMTP id c64mr5709327qkg.78.1575392674409;
        Tue, 03 Dec 2019 09:04:34 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l130sm2062530qke.33.2019.12.03.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 09:04:33 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:04:32 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 03/15] KVM: Add build-time error check on kvm_run size
Message-ID: <20191203170432.GF17275@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-4-peterx@redhat.com>
 <20191202193027.GH4063@linux.intel.com>
 <20191202205315.GD31681@xz-x1>
 <20191202221949.GD8120@linux.intel.com>
 <ee107756-12d2-2de0-bb05-a23616346b6d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ee107756-12d2-2de0-bb05-a23616346b6d@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: V9iWGWMKP_S6dOO2XsuMWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:41:58PM +0100, Paolo Bonzini wrote:
> On 02/12/19 23:19, Sean Christopherson wrote:
> >>> e.g. in a mostly hypothetical case where the allocation of vcpu->run
> >>> were changed to something else.
> >> And that's why I added BUILD_BUG_ON right beneath that allocation. :)
>=20
> It's not exactly beneath it (it's out of the patch context at least).  I
> think a comment is not strictly necessary, but a better commit message
> is and, since you are at it, I would put the BUILD_BUG_ON *before* the
> allocation.  That makes it more obvious that you are checking the
> invariant before allocating.

Makes sense, will do.  Thanks for both of your reviews.

--=20
Peter Xu

