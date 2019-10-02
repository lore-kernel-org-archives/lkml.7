Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732CC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A127821783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfJBMBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:01:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46876 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfJBMBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:01:47 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x92C1GcC011091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Oct 2019 08:01:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0215B42088C; Wed,  2 Oct 2019 08:01:15 -0400 (EDT)
Date:   Wed, 2 Oct 2019 08:01:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.darwish@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191002120115.GA13880@mit.edu>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191001161448.GA1918@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001161448.GA1918@darwi-home-pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:15:02PM +0200, Ahmed S. Darwish wrote:
> 
> Using the "ent" tool, [2] also used to test randomness in the Stephen
> Müller LRNG paper, on a 500000-byte file, produced the following
> results:

The "ent" tool is really, really useless.  If you take any CRNG, even
intialized with a known seed, "ent" will say that it's *GREAT*!

If you don't believe me, disable all entropy inputs into the CRNG,
initialize it with "THE NSA IS OUR LORD AND MASTER", and then run it.
You'll get substantially the same results.  (And if we didn't the Cha
Cha 20 encryption algorithm would be totally broken).

       		  	    	     	     - Ted
