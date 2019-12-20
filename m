Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A48C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXdg4XI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfLTViK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:38:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727422AbfLTViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576877887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgH/TocIdbrujZ/WjTBKFFzHicEM2iW/+AB7POG9On8=;
        b=KXdg4XI9TdqMgyII9MPgBfrgPHfOYwTO/vhsdd+1OOKbl1cIeu8I7xHYusbOp3ErlPEJsz
        u2WkbYZC3PVs/Jr9s3+XXaL+n2kU2GuQcex0AXeE2qX2xjcjpwNudh8OF7MfliYXm+WBRO
        coUTe0stk37GWP26BAXGkfWZKcrPloE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-DPUYjouiPaGGa2D2NOH4Rw-1; Fri, 20 Dec 2019 16:38:06 -0500
X-MC-Unique: DPUYjouiPaGGa2D2NOH4Rw-1
Received: by mail-qv1-f71.google.com with SMTP id e14so6822554qvr.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgH/TocIdbrujZ/WjTBKFFzHicEM2iW/+AB7POG9On8=;
        b=TBHl77DoOaAuvi052uk7EXabXzJ5rytfpxEdZcuLeVWAhxQ80+TBljWdi3si2RNdiy
         LrYD5s9JqzJaThVruETUeAZaKwRbPwGU8eyIIqGwCMGDwCe/iFSnN392DQ7kK9HNEP/4
         EdMsm5AMmv5qwP8q34CQVdQsGJSlL2JL34/670qjmn4g5RGcHxi+7eTktUA5ysqrijBG
         cyHWkT3G2yUAFHiuZ6NcdrObxC7Xm04hqDIYvR3jiQ1ngpWn3qZVoCNhRtq+V4CeaUdH
         d3+4KC3Q//vLpYDMvWMy3km2YSqvwIvjxklSdnC8WvRC18S2QpP45M5rAxInX1Vn3IoQ
         yuQw==
X-Gm-Message-State: APjAAAUhle9akAAm11pWxZpzGen4CvKEeJldgJWY7SmxEcO+l2zvcsqY
        5GBCiM81X97+pXOI4fznRx9o9vuLo/w2uJFHvVgrZnZtX8/3TQR066D1iDKoGBCyRw08U8Dr9tt
        Wm0miXPnqYOWCr2VBFoPwUCkj
X-Received: by 2002:ae9:d887:: with SMTP id u129mr9801518qkf.357.1576877886089;
        Fri, 20 Dec 2019 13:38:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxeshcS8kRdmw06LPZnDTlyOsMQ3kMcPeJ2cQ7Zp4KmJbxpzBkgpKY/e1utdzrBp+XlaW8hkQ==
X-Received: by 2002:ae9:d887:: with SMTP id u129mr9801498qkf.357.1576877885812;
        Fri, 20 Dec 2019 13:38:05 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l85sm3208162qke.103.2019.12.20.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:38:05 -0800 (PST)
Date:   Fri, 20 Dec 2019 16:38:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 00/17] KVM: Dirty ring interface
Message-ID: <20191220213803.GA51391@xz-x1>
References: <20191220211634.51231-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191220211634.51231-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you see three identical half-posted series which only contains
patches 00-09... I am very sorry for ruining your inbox...  I think my
mail server is not happy to continue sending the rest of the patches,
and I'll get this during sending the patch 10:

4.3.0 Temporary System Problem.  Try again later (10). d25sm3385231qtq.11 - gsmtp

So far I don't see what's wrong with patch 10, either.

I'll try to fix it up before I send 4th time (or anyone knows please
hint me)... Please ignore the previous three in-complete versions.

-- 
Peter Xu

