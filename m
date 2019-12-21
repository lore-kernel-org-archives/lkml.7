Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B73C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C623D2070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRaNSTiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfLUCLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:11:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58833 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726485AbfLUCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576894269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ms7ZM3YmtvF2wzYl19JuRjEHViRq+4SWhLPmVosAqLs=;
        b=PRaNSTiEwfbkWk7ldshfHcFVbC7dg33vMdwzg0je0fXAE73S2BLsWYYZdnCec38Qo96H0C
        +pjwYvLqQejarnC+szpv7CrdxcfzhGwyVnirjsLpAl2HXRdcir247/yIzFzfcIksBgf0vo
        k9S/HeMnp4Pb+UHHgqXgAn9nSESmDBU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-iqRv_6nEOdKWM-1y9TGRGg-1; Fri, 20 Dec 2019 21:11:07 -0500
X-MC-Unique: iqRv_6nEOdKWM-1y9TGRGg-1
Received: by mail-qk1-f200.google.com with SMTP id 12so7116176qkf.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 18:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ms7ZM3YmtvF2wzYl19JuRjEHViRq+4SWhLPmVosAqLs=;
        b=soS0hTOgHBkl3pmcFuWmEQOSnL39ILABgJYQv0c9MLssaFkRMd9pwzSdEPEHQUjeOg
         8kJdLzVzT8DAhx4i44dhCq+spdh7/NfbcjjF33RRCnohizpukGwVcHI27flQczbFkjCt
         +tCFjtzUytr0eZ2wokHXxJ3CdBHKBG01mlPaPkgAnzIvWwklwXtJNETW3i2S6u+eW1KF
         xOlvJHrA2Z/uLuJiy+N6BTfiAbr7wVxyaPJMlTbYaBCUilNaxja1f7UpWGNuTHWyfmu0
         7OHOvMmnkL2pEoDpvmypZSrMQ7nEolW6P81TlHIB8ALdPj/8p3XhN4aAE8RR9sod0mSK
         U5YA==
X-Gm-Message-State: APjAAAVl2IiNWDxSM2TyjNgmsns9sVPiOWPk19dxNsMvkt2bi28gfkgR
        xXVQYmOG1fBCLs04uXqaH+m6heDfFjB2wD8EC9332BCn+5R5crwLjoZcMFVpx44SQEBQQzXZXEr
        WckoZG6xnhbYV8gB8YBeGnrLj
X-Received: by 2002:ac8:460a:: with SMTP id p10mr13726113qtn.98.1576894267344;
        Fri, 20 Dec 2019 18:11:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIQ2ze+nInYWvxAbBHNFji24kDf074ME1rfeNCFt0Tp3IQF5g4xn3qTCSfad+ysEPdCVNd1w==
X-Received: by 2002:ac8:460a:: with SMTP id p10mr13726102qtn.98.1576894267155;
        Fri, 20 Dec 2019 18:11:07 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id v5sm3799321qth.70.2019.12.20.18.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 18:11:06 -0800 (PST)
Date:   Fri, 20 Dec 2019 21:11:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 00/17] KVM: Dirty ring interface
Message-ID: <20191221021104.GA59330@xz-x1>
References: <20191220211634.51231-1-peterx@redhat.com>
 <20191220213803.GA51391@xz-x1>
 <20191220214354.GE20453@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191220214354.GE20453@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:43:54PM -0800, Sean Christopherson wrote:
> On Fri, Dec 20, 2019 at 04:38:03PM -0500, Peter Xu wrote:
> > If you see three identical half-posted series which only contains
> > patches 00-09... I am very sorry for ruining your inbox...  I think my
> > mail server is not happy to continue sending the rest of the patches,
> > and I'll get this during sending the patch 10:
> > 
> > 4.3.0 Temporary System Problem.  Try again later (10). d25sm3385231qtq.11 - gsmtp
> > 
> > So far I don't see what's wrong with patch 10, either.
> > 
> > I'll try to fix it up before I send 4th time (or anyone knows please
> > hint me)... Please ignore the previous three in-complete versions.
> 
> Please add RESEND in the subject when resending an idential patch (set),
> it gives recipients a heads up that the two (or four :-)) sets are the
> same, e.g. previous versions can be ignored if he/she received both the
> original and RESEND version(s).
> 
>   [PATCH RESEND v2 00/17] KVM: Dirty ring interface

Thanks Sean, new version sent.  Just in case if anyone read the old
versions: they have exactly the same content with the RESEND series.
I still resent the first 10 emails just to make things simple.

-- 
Peter Xu

