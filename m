Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08612341C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567668137;
	bh=ls7teN0kKPpf63zc2SwYvzkF/bisDmkP7bYlWjLILkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vekHTY7bAlkTIYIgZGlww9kjUn7bCgT4111WPrzXK6vaEZ2DKm3a8POfzezt+HheT
	 BhWqYUNf1cw7iiHX7vi4W4s2c+XbMN/OV1cO/cV2HnUpaglb11tVTS0Pm29lHRZS+S
	 4iGyXKYsLGUOfdKhPL+MQ6z9K3yA9B6BUnkwPjPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfIEHWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:22:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44678 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbfIEHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:22:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id y4so1072158lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JR81XguHf8NA2x2LS/6JeusAt8AO3fo+lEK825RiQgY=;
        b=MPS8NIXkFZvp12JMyV80xqKgl/7yYcgLFHV49k+7eER2cSsl+6KhlYPa7zKLQj6aDv
         0UYIq2HZgdxQ/VPzlxFIlNw9Y14la1t1KK+AKqirIq2uKwoA0xJUqfFKmUAlU7Kqxq8c
         GquXPx8JVl6Gs1mYjRPelZ6bLh/wolothedqDVm2HTXPSnXb8x0NYxnPozRUsSMD4/Mb
         eDrhx5jNFswMBXlnWBwqR+LfaH7ez58oKC7g2VzDGfwsXcbIsOGhazbD7ae91mQosGtJ
         teZ2sJ2bBUHrz5NeTRr62pMlhlCU426EQI+3WMzVJtOYwbcFdMcIHMxtxYJZnD9RPGF9
         ZkFA==
X-Gm-Message-State: APjAAAUPl+3ZUXrZZnBQfuYytaldhwcEracDw1eL6GLAXiU6Qd9d+yfC
        mxbP2TbBa0dAc/yXW/QijjU=
X-Google-Smtp-Source: APXvYqxIZVBiVFBRq6W7rWWvNIi8E2DVFJEM7Yp7Sa+BMdKA5rA5QwsF3dvCQYTsOCRV/mfCpqQwgg==
X-Received: by 2002:ac2:4352:: with SMTP id o18mr1354078lfl.164.1567668134676;
        Thu, 05 Sep 2019 00:22:14 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id f22sm266655lfa.41.2019.09.05.00.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 00:22:14 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i5m5o-0007l4-Ng; Thu, 05 Sep 2019 09:22:08 +0200
Date:   Thu, 5 Sep 2019 09:22:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Julio Faracco <jcfaracco@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        elder@kernel.org, johan@kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: greybus: Adding missing brackets into if..else
 block.
Message-ID: <20190905072208.GD1701@localhost>
References: <20190904203209.8669-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904203209.8669-1-jcfaracco@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:32:09PM +0000, Julio Faracco wrote:
> Inside a block of if..else conditional, else structure does not contain
> brackets. This is not following regular policies of good coding style.

s/good/kernel/ ?

> All parts of this conditional blocks should respect brackets inclusion.

Did you check that there aren't further instances of this style
issue in this file? If so, please them all in one go.

Also please include greybus component you are changing in your subject
prefix:

	staging: greybus: loopback_test: ...

> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  drivers/staging/greybus/tools/loopback_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
> index ba6f905f2..d46721502 100644
> --- a/drivers/staging/greybus/tools/loopback_test.c
> +++ b/drivers/staging/greybus/tools/loopback_test.c
> @@ -801,8 +801,9 @@ static void prepare_devices(struct loopback_test *t)
>  			write_sysfs_val(t->devices[i].sysfs_entry,
>  					"outstanding_operations_max",
>  					t->async_outstanding_operations);
> -		} else
> +		} else {
>  			write_sysfs_val(t->devices[i].sysfs_entry, "async", 0);
> +		}
>  	}
>  }

Johan
