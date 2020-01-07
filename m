Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD81C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC28206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAGTlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:41:02 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49401 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:41:01 -0500
Received: from webmail.gandi.net (webmail19.sd4.0x35.net [10.200.201.19])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPA id D2373E0007;
        Tue,  7 Jan 2020 19:40:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Jan 2020 22:40:58 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] fs: pstore: fix double-free on ramoops_init_przs
In-Reply-To: <202001071002.A236EBCA0@keescook>
References: <20200107110445.162404-1-cengiz@kernel.wtf>
 <202001071002.A236EBCA0@keescook>
Message-ID: <d4ec59002ede4aaf9928c7f7526da87c@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kees!

It's a pleasure to hear from you!

On 2020-01-07 21:05, Kees Cook wrote:
> 
> I think this is a false positive (have you actually hit the
> double-free?). The logic in this area is:

No I did not actually hit the double-free. I'm just following
the indicators from static analyzer.

> nothing was freeing the label on the failed prz, but all the other prz
> labels were free (i.e. there is a "i--" that skips the failed prz
> alloc).

I have noticed that. Thanks for clearing it up though.

The `kfree` I was referring to is in `err:` label of function
`persistent_ram_new` in `ram_core.c#595` of `for-next/pstore` tree:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/tree/fs/pstore/ram_core.c?h=for-next/pstore#n595

Here are the relevant bits:

```
struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t 
size,
			u32 sig, struct persistent_ram_ecc_info *ecc_info,
			unsigned int memtype, u32 flags, char *label)
{
	/* ... */
	/* ... */
	/* ... */
	return prz;
err:
	persistent_ram_free(prz); /* <----- */
	return ERR_PTR(ret);
}
```

So, to my understanding, if our `persistent_ram_new` call in `ram.c#583`
fails, it already does clean up the `label` pointer in itself and 
returns
an ERR_PTR back to us and our skipping logic does its job.

I might be missing something but it seems so.

Thank you for looking into this.

-- 
Cengiz Can
@cengiz_io
