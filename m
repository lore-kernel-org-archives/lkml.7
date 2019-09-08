Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6EC218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567968636;
	bh=XnmOY2flR5s/jiPPR/snDpuCIRSgM5vyitXRQykDP+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i6MexbI4LbL4E615ZrrY/qGcyGfMQVGStD07imqsUD245WOj/AoID1nr94LkIV/JG
	 SJOFf9Rx5mUJZ5XWuJnHSNXnrVKzuNOhHDQ6k6uRECQKYlEEbH3tisP1GBFhQrbTCT
	 hWIc2SQDQgecihqe1xuY0BdikrhRypkXh02OjpX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfIHSuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 14:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbfIHSue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 14:50:34 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2AB216C8;
        Sun,  8 Sep 2019 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567968634;
        bh=XnmOY2flR5s/jiPPR/snDpuCIRSgM5vyitXRQykDP+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4M7/14SyfguCCSPrfiH1RWFoduDosB8S7B3ieC3+0lWBefezAAE7CQQM2CXrto9A
         VlofbGWo5F03IQYtyMBfW58ZnKGzpnDaS4XtGAc/DUrY0ePF79pjTJM8OYWOoHS8YX
         0YK9HzkvUzsZmKQNheMODf0akSY3+aZCFFKStajA=
Date:   Sun, 8 Sep 2019 19:50:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] staging: exfat: drop duplicate date_time_t struct
Message-ID: <20190908185031.GA10011@kroah.com>
References: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
 <20190908173539.26963-2-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908173539.26963-2-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 05:35:37PM +0000, Valentin Vidic wrote:
> Use timestamp_t for everything and cleanup duplicate code.

Wait, how are these "duplicate"?  The fields are in different order,
don't these refer to things on-disk?

Did you test this?

> -struct date_time_t {
> -	u16      Year;
> -	u16      Month;
> -	u16      Day;
> -	u16      Hour;
> -	u16      Minute;
> -	u16      Second;
> -	u16      MilliSecond;
> -};
> -
>  struct part_info_t {
>  	u32      Offset;    /* start sector number of the partition */
>  	u32      Size;      /* in sectors */
> @@ -289,6 +279,16 @@ struct file_id_t {
>  	u32      hint_last_clu;
>  };
>  
> +struct timestamp_t {
> +	u16      millisec;   /* 0 ~ 999              */
> +	u16      sec;        /* 0 ~ 59               */
> +	u16      min;        /* 0 ~ 59               */
> +	u16      hour;       /* 0 ~ 23               */
> +	u16      day;        /* 1 ~ 31               */
> +	u16      mon;        /* 1 ~ 12               */
> +	u16      year;       /* 0 ~ 127 (since 1980) */
> +};

They really look "backwards" to me, how are these the same?  What am I
missing?

thanks,

greg k-h
