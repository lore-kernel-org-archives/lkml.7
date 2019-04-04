Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FD6206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2OZpaJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfDDUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:55:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44452 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbfDDUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:55:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so1952001pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DY8YS7XX12dpTjks6ywbJuHtvWmcDkCE2mEQA8qN5fQ=;
        b=n2OZpaJT2RNV9e9mJm5o2W/jHV+FOuBztZUAXAhs/NzG2r2UDzfEKZFDoiFoZCiMl5
         E7Hd5chP5xQmzhl6ZrM2ejn/DzUrK1j96ClMdVWFFIUKNzJ5qLiBBckupuAyHaTVvS9L
         KwKUPEbWtlmxD/ds7iNNlJLYmD1VzYdHFkEj9D5RdAck9ctk8KKJglgGi1/8tE75Nm91
         k3LnKSDWxVtfkClZ3YOo563faj5KSu68xr5A0FOFH7OTcUHpfe3SK8EOiGf2+uslgGjv
         +9DhPrRuI/A6tKg42XKHo+ZslVtU9cW2mAkXAJwYnTuaN/hm9jUSTV0+kw5quhw6zuis
         941g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DY8YS7XX12dpTjks6ywbJuHtvWmcDkCE2mEQA8qN5fQ=;
        b=VoPGLmJ7pGVEcqbrpWms9pxcyJF7u/bDagPJjV3cTavxh+3FuhaROBXL+S5DJmaDjy
         rEiGlUcxWFh0Z6XAm5mURVhIFtkiL7rDTH74oxBJwcMJra7fyS/in5LyLoVjZEjbMUvV
         56lPRo4FiWIkGiKMWYByFrDVBi41XPxyVBC1usN2RNwDE1L/YlrVXQIqhi1MaeFNKl/T
         DxtktDKl+EHiSCaS9TQrXKMZRHYDJo6ztCRAx5N2rZy30U0YPSdotwtUD9BG5+05qaJ6
         5e+/lpPT9MkF2tdTKBUfD4BT4ae4SZ2fIzxRji+Vzdaa/t1n++OSfqunKvMlZdaN8YP/
         5FHg==
X-Gm-Message-State: APjAAAW9t3NE/vZY2erj2LJWMQc0HxeDTUJyyyzykxWtTQCCEdZOkQd3
        TZDCTSMpB27ppytSV7sGzuCQzA==
X-Google-Smtp-Source: APXvYqzDfO0ewn8JYMPz6bnf4frsPeIdJkVVwG3CiAVTpCifnkUP+uwwWssgRFtF/fUeL3IpsFjK6w==
X-Received: by 2002:a62:7089:: with SMTP id l131mr8332802pfc.158.1554411335580;
        Thu, 04 Apr 2019 13:55:35 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c3sm29433776pfo.2.2019.04.04.13.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 13:55:34 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:55:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
cc:     Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] KVM: SVM: prevent DBG_DECRYPT and DBG_ENCRYPT overflow
In-Reply-To: <0ba6d873-6567-f20a-c5c1-59fc2c97968e@amd.com>
Message-ID: <alpine.DEB.2.21.1904041355270.86558@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1903251146160.188887@chino.kir.corp.google.com> <0ba6d873-6567-f20a-c5c1-59fc2c97968e@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019, Singh, Brijesh wrote:

> > This ensures that the address and length provided to DBG_DECRYPT and
> > DBG_ENCRYPT do not cause an overflow.
> > 
> > At the same time, pass the actual number of pages pinned in memory to
> > sev_unpin_memory() as a cleanup.
> > 
> > Reported-by: Cfir Cohen <cfir@google.com>
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >   arch/x86/kvm/svm.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> 
> 
> Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
> 
> thanks
> 

Paolo, Radim, I don't see this in kvm.git, is it ready to be staged?
