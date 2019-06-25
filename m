Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A50C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04C2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvBCz/Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfFYQ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:56:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36708 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfFYQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:56:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so225630pgg.3;
        Tue, 25 Jun 2019 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bK83zTa34d/KXkbi82In/9/Xz+oQsr3IYBuIQqRd50o=;
        b=dvBCz/UcF4n4G75Q7NrRmFUhQLzXKSZQzOJTy4/n/5RlTWEPHc/MDsHBF1uH/qM2fR
         +i1fZQ1sLEx9Bzp50BWMKASIt2aLqj0QgCbcAoTgaDxirdGAWIzwusyRZK5UPpnUifM1
         o2KVAxiw2IRYNpYDSYCotyi9uEJacHcbu4VGrNk7FCC0ZTwOEAUbgl0srODbfjyw1s3w
         LraoUz6N/cLgmnoa47A/cGWZi9n7KZR4z1yuKYSYebf0LCcNWHgmhJHoL1hgljvCxu+n
         PTYAmYHeoXo3YG9gKnV1rZ24WU16b2s04C1LHel1gMEv75y8N/KbFF05BssbHjsXgyFs
         OxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bK83zTa34d/KXkbi82In/9/Xz+oQsr3IYBuIQqRd50o=;
        b=eGhf5Xb+TReWr9irfr0PUdP/mZ5uLNFNTaBH/QdrMUUh+UgpqnmP+MjJYAaxqmzW7s
         me7tRdKt+BAJtU6JsPYtLWrrNlQt4iRpIdrj5Ho1jvcXoy7yeRiroq6wfvi8hhzdnLOe
         wSUDhTRjs+NGFM7tVqKl33FRJh0ttVLNAENrNmo6xwtHkbRnW4/LIqxFqjlGpAk49WpJ
         FESZqKRu48RSd4yW0373rOQIkSxQIEawS8uZOqcpistuV5WleL+A52jcmMeyNRJ/5eQT
         oVdLeal+niXv9RF65h6CJesWHbpoN0Q6agiHgd193sUOjwcMMXDqhcBWnsXTvpU7keIB
         DLow==
X-Gm-Message-State: APjAAAWs3yC4zx5/GvKIvKvipvXlkIiIDQPDVqdyKPV/l9UKfpCKDKu7
        tuOnisoCxVPgf5hSbRRYsOUhLYxe8jM=
X-Google-Smtp-Source: APXvYqz16a2CNmNDX90XGSIt9WWz8e9FHgjvaiP6MpkRu71CJ40y9e1tWvHH9ImfRidNlozE8DybWg==
X-Received: by 2002:a17:90a:2163:: with SMTP id a90mr31515981pje.3.1561481799115;
        Tue, 25 Jun 2019 09:56:39 -0700 (PDT)
Received: from continental ([177.132.134.92])
        by smtp.gmail.com with ESMTPSA id g2sm14134483pgi.92.2019.06.25.09.56.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 09:56:37 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:57:11 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH v2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190625165709.GA31932@continental>
References: <20190618224454.16595-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618224454.16595-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

humble ping :)

On Tue, Jun 18, 2019 at 07:44:54PM -0300, Marcos Paulo de Souza wrote:
> If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> 
>  Changes from v1:
>  changed the check of try_vpd_pages from:
>  	sdev->try_vpd_pages == 0;
>  to:
>  	!sdev->try_vpd_pages;
>  (as suggested by Alan Stern)
> 
>  drivers/usb/storage/scsiglue.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index 59190d88fa9f..30790240aec6 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -195,8 +195,11 @@ static int slave_configure(struct scsi_device *sdev)
>  		 */
>  		sdev->skip_ms_page_8 = 1;
>  
> -		/* Some devices don't handle VPD pages correctly */
> -		sdev->skip_vpd_pages = 1;
> +		/*
> +		 * Some devices don't handle VPD pages correctly, so skip vpd
> +		 * pages if not forced by SCSI layer.
> +		 */
> +		sdev->skip_vpd_pages = !sdev->try_vpd_pages;
>  
>  		/* Do not attempt to use REPORT SUPPORTED OPERATION CODES */
>  		sdev->no_report_opcodes = 1;
> -- 
> 2.21.0
> 
