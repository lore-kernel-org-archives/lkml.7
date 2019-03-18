Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD9BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70412070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="rcBAWadi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCRIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:46:48 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:19350 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfCRIqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:46:48 -0400
Received: from mail-sz.bfs.de (mail-sz.bfs.de [10.129.18.200])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 91B49202F0;
        Mon, 18 Mar 2019 09:46:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1552898806; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=JvEE2mTUc30JllaX1+6NsHckDZE2Hl0Ky/aKSd1yyTY=;
        b=rcBAWaditiE4LC0jrjQuPtUaxR6WDdTZ2DFwVbFFX/bWZH7q4trT3cdDRTx3uEotZJZulP
        tRN15zzfzFBLc/xFK3pc+S4kApg+Ie0JQx83y7VBJe6WIIVeHhG7phlrCD8kWjfOe75ROy
        r85M71I2lNZndo5CHBbB0s1DNKhUVxpZofJJ3sULd+iA614AqkHzdqJh+NkYX/QgkdW5G4
        RGVLJM+gV+11hmY4vkGJXY9B85YtzamqD7+RY1GbDojpvVlHXX+uRi2PNZK8NgbG4hz6V9
        wNkF3577yRki7flHdkknSOi/+SFswKVmL37UGVbgeaAT6BK0RYmX+YMYK0lHmQ==
Received: from null (ox-groupware01-sz.bfs.de [10.129.18.42])
        by mail-sz.bfs.de (Postfix) with ESMTPS id 44F937F51B;
        Mon, 18 Mar 2019 09:46:45 +0100 (CET)
Date:   Mon, 18 Mar 2019 09:46:44 +0100 (CET)
From:   Walter Harms <wharms@bfs.de>
To:     kernel-janitors@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <430554945.231221.1552898805187@ox-groupware.bfs.de>
Subject: Re: [PATCH] hostfs: fix mismatch between link_file definition and
 declaration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev44
X-Originating-Client: com.openexchange.ox.gui.dhtml
Authentication-Results: mx01-sz.bfs.de
X-Spamd-Result: default: False [-2.10 / 7.00];
         ARC_NA(0.00)[];
         FAKE_REPLY(1.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         HAS_X_PRIO_THREE(0.00)[3];
         NEURAL_HAM(-0.00)[-0.997,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Colin is obvously right with that.
But my guess is that the error occured because the
pattern (from, to) is brocken here. Also 

Maybe the maintainer can fix that.

just my 2 cents,

re,
 wh


Am 18.03.2019 00:09, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function link_file declaration in the header file has the order
> of the two arguments (from, to) swapped when compared to the definition
> arguments of (to, from).  Fix this by swapping them around to match
> the definition.
> 
> This error predates the git history, so no idea when this error
> was introduced.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/hostfs/hostfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
> index 33b8423ef0c9..f4295aa19350 100644
> --- a/fs/hostfs/hostfs.h
> +++ b/fs/hostfs/hostfs.h
> @@ -87,7 +87,7 @@ extern int do_mkdir(const char *file, int mode);
>  extern int hostfs_do_rmdir(const char *file);
>  extern int do_mknod(const char *file, int mode, unsigned int major,
>  		    unsigned int minor);
> -extern int link_file(const char *from, const char *to);
> +extern int link_file(const char *to, const char *from);
>  extern int hostfs_do_readlink(char *file, char *buf, int size);
>  extern int rename_file(char *from, char *to);
>  extern int rename2_file(char *from, char *to, unsigned int flags);
