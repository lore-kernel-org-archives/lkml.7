Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77EFCA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F44C222C1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571363692;
	bh=n/2ldw6fuwdIVyFL1N1LR35RUjGj6Jo0lZiH4P0ReCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BN06O5MPWy4TaqgYGcsdV2ozbvVwTOLxw0jwEsceAx/wbpYHRsqRHoLDi6xJw8kBH
	 NmdvM6J4IOWRom5CAS2e86P70P/M3eMClz7MGkXT2u76wDhZBrZ4xBKwQCndn9unzR
	 OOKTHhq3ol2M27DH4zM7ndSgryz0cHxhqAwG7ej8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409523AbfJRByv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:54:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36366 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406929AbfJRByu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:54:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so3889504qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3auhKvuKP51CazAFw/ZQ6kZs7gPKtasQpSNKpkuAgas=;
        b=aHvukMC+I42J0tLrfVVGW4aXbe5FW8pSPHw72Ppxd9LwjKYhIjpREkZ3QkKj+7bkFd
         gyxo/xKRnfQKKSWJqyFVq8Uzd0yMTLVpWuGV32lRhDX0HkxhpV+KmdBcA5dsXcgZYGON
         os0PdWT4ngsHYsWxRVdw2SjREt+q3UEpxPr70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3auhKvuKP51CazAFw/ZQ6kZs7gPKtasQpSNKpkuAgas=;
        b=G8wa31B3OrzPLuWoyK529O7SwSTjf8Gz3IAL0AeUgXOxEiedjbsLYUaA9wVU3gZNzU
         7fs0iZqeJt00GT7CJ57SUEuW1qtqfFHKOlQfh8r4mgkvdXcidGbXWXp1MrX2TWsQheJr
         wzv8uKHJ3y4T0cxscxmjjo5J5Bk+LcgA5fBZEhP0xvFqtl+SIDU11A9MFXO/xWWeTgA+
         BwLI+XIMqAlCLF5NxPttue2jQvVQFObwqZXGJeZa9lUraeLwMbsu96Eciufmm0QB7JHJ
         WMxG0kAkZFJGuU9sqGa5kouZsmqLQVOp+y90AUeY1+l0a02D4Bxfx3nbBq6qSpoMxrA/
         iYvg==
X-Gm-Message-State: APjAAAVa4Fi2RkvCUIqqo4hDZS9/SIkCl9AqjGi3qkJrXqtBh0UP+H+m
        E2yJZwxpe2fd6fG7RG6VTmMEsQ==
X-Google-Smtp-Source: APXvYqwLLb+h/QZFXCl09cOrHAXP/i2RNRv109OUAZ3gs48s7CJtS8nEhvvJZ7GrtrHTMXpbYxXqAA==
X-Received: by 2002:ae9:ea17:: with SMTP id f23mr6238401qkg.49.1571363689689;
        Thu, 17 Oct 2019 18:54:49 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id v4sm2212270qkj.28.2019.10.17.18.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 18:54:49 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:54:47 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <greg@kroah.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018015447.GB6446@chatter.i7.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
        Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
 <20191017204532.GA6446@chatter.i7.local>
 <20191018013029.GA1167832@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191018013029.GA1167832@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 06:30:29PM -0700, Greg KH wrote:
>> It could only possibly work if nobody ever adds their own 
>> "Signed-Off-By" or
>> any other bylines. I expect this is a deal-breaker for most maintainers.
>
>Yeah it is :(
>
>But, if we could just have the signature on the code change, not the
>changelog text, that would help with that issue.

We totally should, and I even mused on how we would do that here:
https://public-inbox.org/git/20190910121324.GA6867@pure.paranoia.local/

However, since git's PGP signatures are made for the content in the 
actual commit record (tree hash, parent, author, commit message, etc), 
the only way we could preserve them between the email and the git tree 
is if we never modify any of that data. The SOB and other trailers would 
have to only be applied to the merge commit, or migrate into commit 
notes.

-K
