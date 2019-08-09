Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A6BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1551208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565362512;
	bh=6UZ3leBBMO0gz5ZTMqNOSfRC2julb8UgZtsX/FySUWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DP3+qoM7FBHmzJqEGRJ7kfPbqpfG6QP6fluyWQ8QTeWPkJWwIBTn0meC17tQjvB2Z
	 /a7osaFKcGayBLSLsJeOdDw7LTEjZrWNjjM8CqTLaBJN7wBXa3EJBEWx6Du26cbD6H
	 Tb+TGO1wdEuLmea0TWr2I+y3Daa3zs+KrVvVKugs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407114AbfHIOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHIOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:55:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D895B2085B;
        Fri,  9 Aug 2019 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565362510;
        bh=6UZ3leBBMO0gz5ZTMqNOSfRC2julb8UgZtsX/FySUWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNQ9bNrC7tia+79A9N/lhAoiQzGjo9kRMJ9QPmoLKgwugQcPDWr024ZlKnAIiSlH2
         XX9InHC9hkL3RBhorx1JlFhsJsW1x/t0ReJgEUFq9RqXw4j9wvbaosOBXqByGvckp/
         qKvx4cTpD8QGjJ0WPjflcb52MxwNymAUJ+l1gg0c=
Date:   Fri, 9 Aug 2019 16:55:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 2/2] binder: Validate the default binderfs device
 names.
Message-ID: <20190809145508.GD16262@kroah.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-3-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222727.132744-3-hridya@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:27:26PM -0700, Hridya Valsaraju wrote:
> Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
> This patch adds a check in binderfs_init() to ensure the same
> for the default binder devices that will be created in every
> binderfs instance.
> 
> Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---
>  drivers/android/binderfs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index aee46dd1be91..55c5adb87585 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
>  int __init init_binderfs(void)
>  {
>  	int ret;
> +	const char *name;
> +	size_t len;
> +
> +	/* Verify that the default binderfs device names are valid. */

And by "valid" you only mean "not bigger than BINDERFS_MAX_NAME, right?

> +	name = binder_devices_param;
> +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> +		if (len > BINDERFS_MAX_NAME)
> +			return -E2BIG;
> +		name += len;
> +		if (*name == ',')
> +			name++;
> +	}

We already tokenize the binderfs device names in binder_init(), why not
check this there instead?  Parsing the same string over and over isn't
the nicest.

thanks,

greg k-h
