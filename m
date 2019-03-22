Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D539F218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553231889;
	bh=1RwfR4wZGg5wvqtXX5QnuvT9FxKwsePFHu69Ic59dXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u/Fpa/Q8Fj1e9NwsSKYNwQIbEbjqDaytk+4rk+DKLJTxDkVyiou+jlCQxJZ1DsBZR
	 aVeXp3KeSu/5U+ZCSJBnfWR/k0K4sF7Tsoo4VPre227ROB4AZefKqS3ShFRi21ubKS
	 P15C5zXU64eHmlWUkbDGSsaNYnA+PUrEuyC17/WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCVFSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfCVFSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:18:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07010218E2;
        Fri, 22 Mar 2019 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553231884;
        bh=1RwfR4wZGg5wvqtXX5QnuvT9FxKwsePFHu69Ic59dXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdzDZdwxoelcU7q4dhtHFGdZ0QImu3PCZ+B0W1Er/URXWudT3sVnfc631JbRefTEX
         3eYyuv29Mht1SAkKxYNJo0mFlwonP/GL6eem5Ss/B6ulIQtvGVN3uxNMJkQLmohRV5
         yNUgNGiT6pURCn8Xvew4AOTD7kbl8yeE65LMxvvY=
Date:   Fri, 22 Mar 2019 06:18:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jarkko.sakkinen@linux.intel.com, grawity@gmail.com,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190322051802.GA17257@kroah.com>
References: <155320933278.5015.1752135965699928631.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155320933278.5015.1752135965699928631.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:02:12PM -0700, Tadeusz Struk wrote:
> The poll condition should only check response_length,
> because reads should only be issued if there is data to read.
> The response_read flag only prevents double writes.
> The problem was that the write set the response_read to false,
> enqued a tpm job, and returned. Then application called poll
> which checked the response_read flag and returned EPOLLIN.
> Then the application called read, but got nothing.
> After all that the async_work kicked in.
> Added also mutex_lock around the poll check to prevent
> other possible race conditions.
> 
> Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Tested-by: Mantas Mikulėnas <grawity@gmail.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
