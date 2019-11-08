Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98070C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9B621882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rg+96yAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKHPeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:34:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45211 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKHPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:34:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so4773721pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qj+fxcw/f/zBWkhx1n1H3p7wLqAe4gVBZqI/aXNQxWk=;
        b=rg+96yACuf0WNFAbNBolENWXNfzTsgllhU9Lu/cKxAhsm9fNVQMjn0iHib5iXLrIKy
         4ht2PRAcyGbqzSaBjjbBD2EOEsb07PYkPuF9ikvH43uGaUPfIbtJk8lFDkPCLI1XR8hS
         2AVs+/sUSn4eOTnMkIjAK0XPcmykZsVhmQTIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qj+fxcw/f/zBWkhx1n1H3p7wLqAe4gVBZqI/aXNQxWk=;
        b=N870y9NT0iconw4PZtAIyC/ShYWQiZZN0vf/X+uDf90Gya4TGTmd2CWBanAETyQrWC
         50QCfht6EcHYhlyIk03YOH+sQ6xvxOSbnlmqvs0Ftb7gKK76Nf9aSf6g+2DJUEFfP+53
         vTsTrpnbN+25c84LM++MBF3m9eWNoMFcfeWES1cVTXZou9hlMeR5VArngsF3qYYVO+t5
         9SZgoJ5MA28zhKYJRYdVk1wDWYguXlnvlOx0IsjjShbR7/zrS3M4+XI/IVe0qWYCzZfB
         ktoy/OQUmQczadfybA0wmTwilgbBfvr/tR4KvA6jN+XvGqRiPZYjUrdj03VG27bl108E
         O0zw==
X-Gm-Message-State: APjAAAXu6L/RPqmHW0rMwaB3HQrIpggadWlrZS6EnzY6UELS0JtTWxx1
        AV9WiLgWp9g975+DNduVFa1qEA==
X-Google-Smtp-Source: APXvYqwSoI3TF80yU99qYDKkeTfcy4sTEJwGlf6rpu9XXhNevu4ndPDIEfa5bbnolSMgHzBhXQTIQw==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr14324030pjj.50.1573227252739;
        Fri, 08 Nov 2019 07:34:12 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b128sm2331777pfg.65.2019.11.08.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:34:12 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:34:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108153410.GB99567@google.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
 <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
 <20191108020614.GA99567@google.com>
 <20191108063715.GA513315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108063715.GA513315@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 07:37:15AM +0100, Greg KH wrote:
> On Thu, Nov 07, 2019 at 09:06:14PM -0500, Joel Fernandes wrote:
> > On Thu, Nov 07, 2019 at 05:00:23PM -0800, Andrew Morton wrote:
> > > On Thu,  7 Nov 2019 14:53:54 -0500 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > > 
> > > > F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
> > > > A private mapping created after the memfd file that gets sealed with
> > > > F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
> > > > children and parent share the same memory, even though the mapping is
> > > > private.
> > > 
> > > That sounds fairly serious.  Should this be backported into -stable kernels?
> > 
> > Yes, it should be. The F_SEAL_FUTURE_WRITE feature was introduced in v5.1 so
> > v5.3.x stable kernels would need a backport. I can submit a backport tomorrow
> > unless we are Ok with stable automatically picking it up (I believe the
> > stable folks "auto select" fixes which should detect this is a fix since I
> > have said it is a fix in the subject line).
> 
> Never rely on "auto select" to pick up a patch for stable if you already
> know it should go to stable.  Just mark it as such, or tell stable@vger
> after the fact.

Sure, agreed.

Thanks Andrew for adding the tags!

thanks,

 - Joel

