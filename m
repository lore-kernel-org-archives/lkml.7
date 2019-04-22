Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08003C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD13720874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6dZX1+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfDVPlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:41:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39558 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVPlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:41:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so5891949pgj.6;
        Mon, 22 Apr 2019 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gXYtroXiYVRWPoTwZ7DmD5A/QVoBluJQOy5jcAR8Msc=;
        b=l6dZX1+b1I3zrRHOSt7u9ab9BU7D/UF/FQcRJFeQcRBnUUTBxs6CvuQXj37UbpOVP4
         w2zgcj7EBdrsYauNOBJIjQLL92HLGRGLUXup3hvrdvVGa0PiyJ+V+8aHLSmtb37oJTOL
         6qsD4S/Cs3UJzMPY/qhaSCt6bm6YbN9KYScuErlfSVez5rrIyVwdHcl9qGw8YT+ogoRE
         CLZpsBNnvNb3y61iIrAIIC9b9spaAayHRrDLCPsHn01ZM/mTz2N6+vp6DzN2nCNxqqeg
         k3oS7Jhg+v64cB0S0Elkl654cePJ3jWVBxuzNqMQAGQe7XiMehKhO85EOubmmXsTKdKi
         /kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gXYtroXiYVRWPoTwZ7DmD5A/QVoBluJQOy5jcAR8Msc=;
        b=COvAAQbJJ/YcxqjKSmnhDdnRZQO0qeBDgX65YhFaxw+VkpYkOKreePbOdn8jFtA2Lr
         2vHH1wzkrRgOj4GqEia8fVSxa0ZeFoubx9ftS9JTi5EqYzOY341O2Z75WaWdBGi6Sxp9
         WrcuDZxz5J2bDZ+I38MM1/BOD3+YlgVvt/6pvZWF7dUySc9xCJjH+M2fGYyDSZLnOWTB
         m0pS9DiKztnwvuhuGIt53/pB6MoAYhPkOeR9pYBz1qdAZm6x9HLU36+tSo7SIDYnbA6n
         GgFQDHAdDTXeC0RzA2tr4ytWydWmfIcEqQfDdgGWfayJ+SUFHqYGRrNZFowaAPgQXhnM
         95qg==
X-Gm-Message-State: APjAAAWxY0AmoUTMaMqexumNBOm4m8yWbEbl2YTe5GouH9eFmnK1h6IZ
        35JXKFh2exabMk8iIDhf+p4=
X-Google-Smtp-Source: APXvYqys1m9go2cal+0K9TZ3AhadTptw7nFT/KUmX8RNBIJ4JUp02Th+E7/5P8yR6uO6owveLZd1+Q==
X-Received: by 2002:aa7:9ad4:: with SMTP id x20mr20772356pfp.250.1555947662547;
        Mon, 22 Apr 2019 08:41:02 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id u5sm19343629pfm.121.2019.04.22.08.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 08:41:01 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:40:59 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 28/79] docs: ptp.txt: convert to ReST and move to
 driver-api
Message-ID: <20190422154059.pv7ybtylc53azdxo@localhost>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <21d7862dfaaa7a587469aacf7b8a2e55cf705bfd.1555938376.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7862dfaaa7a587469aacf7b8a2e55cf705bfd.1555938376.git.mchehab+samsung@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:27:17AM -0300, Mauro Carvalho Chehab wrote:
> The conversion is trivial: just adjust title markups.
> 
> In order to avoid conflicts, let's add an :orphan: tag
> to it, to be removed when this file gets added to the
> driver-api book.

Acked-by: Richard Cochran <richardcochran@gmail.com>
