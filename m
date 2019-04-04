Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F664C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478F206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTxNJy1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfDDUzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:55:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfDDUzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:55:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1822711pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uY/dwrxLiNqO1JfhVdCU2k0lsjFUdcV+FSJRLP9wexw=;
        b=pTxNJy1GF7cg4lweaxl8B+Ig2Bur4s5IAUvUT7uqziuIIpv8YfW7iiHXRDMKDhnj0D
         Ydq3+Bc0HcVediTeWaxh/gpRp078SUMr8NpRpZXtiLENj32+rqvZjbJJ6i5ATgtX5z4S
         kP8WIZdOE0tL+za16bKdk4BV1qrJnEgXnpr53wpUAfssLGatH2gAdIvi0n1xH3J/46Js
         6ajlMY/J2HvMS2RbxXVUb/bRGVoVy90SOUrd2X63QTXAxKG316cUgTRNmKbTxH1SjKoe
         h+cIwRrKTq69LVp5pZTgbzxvXLFR6TWgy5BTiDMa60qrll7GCBW9YgwmD1Ivq272j7bZ
         5hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uY/dwrxLiNqO1JfhVdCU2k0lsjFUdcV+FSJRLP9wexw=;
        b=IvjT55V1ohAd+z8wd4feU8JFbSLFUGOkR1orA8qY7n0REbOyL1qqXDiBDqm9h4LqVE
         lTnOdrm7aNwVlAUrB8KqrkgXCJuBFh01wcUD/Zr7vnRvZq+SExQUKCzlYJRpWiGrsXEs
         uDN08f8GjQxMMAL3UiIWvlYxUu/l7T26tpiCBzRvAWpEq+jVoXj+9d5i6cQtun5LxdcK
         F5NjfExY1JLeqQcRw/weECEpNsUtu4gQW6/ZC5qK3TgL8ZpDWEOoa2wMOTRZUGnZARSu
         G/FXVTipwdgx8ID0RNTeHNH9Zdb7C4+lZz2nzQyQpLkqgtY9uuHYzOQbcG4FVyDBIf4q
         7s6Q==
X-Gm-Message-State: APjAAAVxjIJYQwpubRJPEYUvcs/XmXfX2m1ZiNUpAShLVFEHJTOgEa3K
        xBLVXb2/H+n6/078LHgJxv6k+Q==
X-Google-Smtp-Source: APXvYqxmmOIPWBDN8s2adCpIxWymfIy3Ehvimez/iGWO3laKIZe3OV0RapvBFTE7xee7mHLbhZfVgQ==
X-Received: by 2002:a63:2747:: with SMTP id n68mr8000096pgn.317.1554411315008;
        Thu, 04 Apr 2019 13:55:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i2sm29188444pfo.9.2019.04.04.13.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 13:55:14 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:55:13 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
cc:     Joerg Roedel <joro@8bytes.org>, Cfir Cohen <cfir@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kvm: svm: fix potential get_num_contig_pages overflow
In-Reply-To: <f5f8e58b-dd19-158e-5428-6631e49cee8e@amd.com>
Message-ID: <alpine.DEB.2.21.1904041354330.86558@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1903191517380.256304@chino.kir.corp.google.com> <f5f8e58b-dd19-158e-5428-6631e49cee8e@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Singh, Brijesh wrote:

> > get_num_contig_pages() could potentially overflow int so make its type
> > consistent with its usage.
> > 
> > Reported-by: Cfir Cohen <cfir@google.com>
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >   arch/x86/kvm/svm.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> 
> Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
> 

Paolo, Radim, I don't see this in kvm.git, is it ready to be staged?
