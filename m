Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17468CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2620862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW6pWi5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJaW44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:56:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728074AbfJaW44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572562614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=hsazX/2cdvsd2UrhLyRGFR2m9XT3QtbL6U2YX0qY3fM=;
        b=UW6pWi5ysStrutFkHe+2TEMH9JFUxP3fp+K9YpLSjmL03F9+DoXLV/GGfXiL73xZD2oGI7
        LP8McNvuWKeozhrzVq/DZPensw2KoyvlT5wbxbDiz+IAzwhMqEeZ2lE23s30RY5ShRIG/T
        TigYW3dOOs/CHoXsB/2Ydc6L0w4r6gQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-3ZOH7PXIMnKMRgLfr2sItg-1; Thu, 31 Oct 2019 18:56:51 -0400
Received: by mail-wr1-f70.google.com with SMTP id l4so4369665wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 15:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLka1Wegs5Poy1s6KcdsjNpn4BlCfTOrvfQWXEfo7jw=;
        b=FA+YeOyKu9/UA6ne51Y5kr2N4F9KpDVTuuSlPOR0E3SNZVhpl79lakvg+bZkKGV+4M
         CQAfqSQWfw4iGJG6lUY8P42QkWkrGVG1qDhNkA5M7hEndNjnzk2x0RvtoFgUM9BQxTMu
         AF+uV3ADcur1tvOSSQP4zs+OSUe9HPM26uM9wud33oZS5p+VKZS5I/ThC5q5Db/Lo6cB
         zy9gzky4nJAKlbzBw689EKzrbcm1YNqTYP9KmZG75wL/5FJTUGjmezH0eJNCfsXR3yXz
         sa0ZXW9CEZXuvukawvZSYRkGCBpe9gJ1Q/JLa/b8KBu3BTauvL5VMzLEMYTxLpWfn6bW
         oAoQ==
X-Gm-Message-State: APjAAAXt1Y9OzAKhJyKLcr2wtLrV1VaJXVdGr88Xj/bl8UALSVGdyC86
        1L7X2H9i2ycntj8uJXd7zkKEhF+UtxsHWM3hFmqoik3AXvph3wBp6YNuRZKTd6DrX9mifvZV46T
        Ee2JJpGE7/N/CwzkbJRRMLSzO
X-Received: by 2002:adf:db0d:: with SMTP id s13mr7666996wri.319.1572562610334;
        Thu, 31 Oct 2019 15:56:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzv6DS9Kcssbe/HxbCJzzfTDCkzm4UhsJt0D6LeXtynHPukfhwlCvibJv4SH0s9VZ2rReHldA==
X-Received: by 2002:adf:db0d:: with SMTP id s13mr7666976wri.319.1572562610034;
        Thu, 31 Oct 2019 15:56:50 -0700 (PDT)
Received: from [192.168.20.72] (94.222.26.109.rev.sfr.net. [109.26.222.94])
        by smtp.gmail.com with ESMTPSA id w17sm5812390wra.34.2019.10.31.15.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 15:56:49 -0700 (PDT)
Subject: Re: [PATCH 3.16 47/47] KVM: x86/vPMU: refine kvm_pmu err msg when
 event creation failed
To:     Joe Perches <joe@perches.com>, Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Like Xu <like.xu@linux.intel.com>
References: <lsq.1572026582.631294584@decadent.org.uk>
 <220d8f2c1b299d2e71fdcf50b98286aae5b0c6f2.camel@perches.com>
 <05be6a70382f1990a2ba6aba9ac75dac0c55f7fb.camel@decadent.org.uk>
 <3078d0a186cca2dfae741908ffff41f1bdb30eae.camel@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <35a63ec6-234b-3dda-fbbc-df344e97e468@redhat.com>
Date:   Thu, 31 Oct 2019 23:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3078d0a186cca2dfae741908ffff41f1bdb30eae.camel@perches.com>
Content-Language: en-US
X-MC-Unique: 3ZOH7PXIMnKMRgLfr2sItg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/19 23:53, Joe Perches wrote:
> I think not, but hey, maybe you and Greg do.
>=20
> Porting enhancements, even trivial ones, imo is
> not a great thing for stable branches.
>=20
> My perspective is that only bug fixes should be
> applied to stable branches.
>=20
> cheers, Joe

I agree this is borderline.  The main reason why I applied is that I get
occasional bug reports about it even from experienced Linux developers,
probably because the printk_once hides the message on systems that have
been up for a while.

Paolo

