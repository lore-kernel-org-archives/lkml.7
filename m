Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34502C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AFC21874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfCNXH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:07:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44811 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727489AbfCNXH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:07:27 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x2EN72P5022266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Mar 2019 19:07:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 27E6A420AA8; Thu, 14 Mar 2019 19:07:02 -0400 (EDT)
Date:   Thu, 14 Mar 2019 19:07:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Richard Weinberger <richard@nod.at>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-mtd@lists.infradead.org,
        linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com
Subject: Re: [PATCH 4/4] ubifs: Implement new mount option,
 fscrypt_key_required
Message-ID: <20190314230702.GE6482@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Eric Biggers <ebiggers@kernel.org>, linux-mtd@lists.infradead.org,
        linux-fscrypt@vger.kernel.org, jaegeuk@kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paullawrence@google.com
References: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com>
 <20190314171559.27584-5-richard@nod.at>
 <20190314174913.GA30026@gmail.com>
 <1957441.Hty6t2mpXG@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957441.Hty6t2mpXG@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard --- stepping back for a moment, in your use case, are you
assuming that the encryption key is always going to be present while
the system is running?

Ubifs can't use dm-crypt, since it doesn't have a block device, but if
you could, is much more like dm-crypt, in that you have the key
*before* the file system is mounted, and you don't really expect the
key to ever be expunged from the system while it is mounted?

If that's true, maybe the real mismatch is in using fscrypt in the
first place --- and in fact, something where you encrypt everything,
including the file system metadata (ala dm-crypt), would actually give
you much better security properties.

       	       		     	 	- Ted
