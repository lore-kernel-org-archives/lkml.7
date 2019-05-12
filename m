Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E47C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDD520C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="Zi0SN6eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfELSoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:44:19 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:60694 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfELSoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:44:18 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 1A78220366;
        Sun, 12 May 2019 20:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1557686652; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otGbpeOBUxPubh373VfctsNYuIcg2bUblAv6dqaMf+U=;
        b=Zi0SN6eD6GaX54lrqv1SUnB2TXa1kiIxMJbfaWBuWg9lMTdFZYu+54FfVG1WP9YeLgs6gg
        ds84cy9FxPewKnawtYrFvAkrGVaU1nviZz8yEw9g/7gNv72YN+u8/dsG4AXuflBA4yLETz
        SSjWvHN84sshvI9FqFOVvrFgiqCXWDH+sVWckJ1AITC2bsKNm0YYuKWMlG7d0VE2wwAcUF
        WRbOm2bkKYuWFuPCXz/YJE/IQAAd2x9SqZ5PEZYE/Qz9ZldGnzP0UzqIT9MoUX3yOoLjQD
        Hh/WzeKpFBHv9AZ8tPZI2B9USzAGTwZIqj6kaTsyuKspwii2Bmgcx7+dfoftAQ==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 99460BEEBD;
        Sun, 12 May 2019 20:44:11 +0200 (CEST)
Message-ID: <5CD8697B.6010004@bfs.de>
Date:   Sun, 12 May 2019 20:44:11 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     David Howells <dhowells@redhat.com>
CC:     colin.king@canonical.com, joe@perches.com, jaltman@auristor.com,
        linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Fix afs_xattr_get_yfs() to not try freeing an
 error value
References: <5CD844B0.5060206@bfs.de> <155764714099.24080.1233326575922058381.stgit@warthog.procyon.org.uk> <155764714872.24080.15171754166782593095.stgit@warthog.procyon.org.uk> <31808.1557684645@warthog.procyon.org.uk>
In-Reply-To: <31808.1557684645@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         TO_DN_SOME(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 12.05.2019 20:10, schrieb David Howells:
> walter harms <wharms@bfs.de> wrote:
> 
>>> +	ret = dsize;
>>> +	if (size > 0) {
>>> +		if (dsize > size) {
>>> +			ret = -ERANGE;
>>> +			goto error_key;
>>>  		}
>>> +		memcpy(buffer, data, dsize);
>>>  	}
>>>  
>>
>> i am confused: if size is <= 0 then the error is in dsize ?
> 
> See this bit, before that hunk:
> 
>> +	if (ret < 0)
>> +		goto error_key;
> 
> David
> 

Sorry, you misunderstood me, my fault, i did not see that size is unsigned.
NTL i do not think size=0 is useful.

You get size from outside, and if i follow the flow correct
the first use of it is to check size>0.
perhaps you can check size at start and simply return.
Now if size==0 it will return dsize and give the impression
that buffer is used (it is not).

while you are there:
  flags |= YFS_ACL_WANT_ACL is always flags = YFS_ACL_WANT_ACL;
since flags is 0 at this point.
IMHO that sould be moved to the strcmp() section.

hope that helps,

re,
 wh
