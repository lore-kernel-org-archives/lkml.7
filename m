Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A64ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B524C20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571150258;
	bh=+PszFwIqrlyxVVAbm1B+dbB8MBd5bWJNQBIiWxZXCqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TtQNTOafOzID5UNhJi7I7GZHemuByDyintWhtBzFZ33vIrfVvqOloKBl1tstyOh3z
	 1vMRJMnggdbVDdhSAzU43u/oY3fEJ0IQunYdD9+Agyo/ZKFPSudN6oKECqdAWgXkCo
	 yQtdfdpVbMbOcBjtzseUFoeKQP2OCMprBp1z33uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfJOOhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:37:37 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:34992 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732895AbfJOOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:37:37 -0400
Received: by mail-qt1-f174.google.com with SMTP id m15so30921414qtq.2;
        Tue, 15 Oct 2019 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4H4Rg3pemm2hU+dY5X0GYDMJ3NZ74bBGNLSG2pqHsAo=;
        b=WQdx67izKGSUfSAPo9NF9EtD6TtVRgKmrTLP7Ii/UP/qFn8MOeSsLPeRB2VVvs6Au8
         zbZCjqvbOmm8mSIYi2gxAXkpXZpVBJAkoZMkLk5dpTQycQUrS3hoytSY+5VeoW5ocohI
         toqTug4fi9M48G3JmMcZ0II5LDHN4j2jfZKetM8Fq2C7otn/RIA9x6V5sSMSHZ7SwhAq
         fplUsnkIDDlCSJXkpZ7lr/xlEnLHq77HtoTcm2YXFEPp/k7vtWz3jIORKHuw/wBtc8d/
         R7gWmNNkxXfvKW2j9JbzwjZ4TqwHP0bACSq4cfuIICtM6cV3uz0TdlrXDJtk0vVmb956
         2zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4H4Rg3pemm2hU+dY5X0GYDMJ3NZ74bBGNLSG2pqHsAo=;
        b=ER8D3Gy2hEJoqOBKvtLDE1Ou1rCj9uXtc4KzmUzH59QzJJh/cudQAwewuhZZHKVR8U
         AAH78z7aIR4TERKfeTDvg4ulK5KYmNEoH8NLrILsbkrDOVqDxEs+WdrUud/p+nyufAlS
         ceAKQoYB48XZDJ43f39zSZeyo9UYkNXbaDek4EWijb/wZRIv9MhWiwTxbGYvOD7RYeKp
         mc7k9YKhb1b9tpoFaTdWv9WpGqYpJ2GbxNXhzfuv9dQxeg5Aq8L5+VMCQdU29hIdeq5o
         86FlCwnExYcpZn+eh4gw4Et363ODMznOTyr6uqpdOvW/mktEGdd0xf6iuRJSl6CWTffS
         +UPQ==
X-Gm-Message-State: APjAAAUrA4q1p5327AIEIezK01wkh8zKGMkUl1cv1kL6WT6qcTt3EbkJ
        8WYppDZD8I7b4c8dy9IKYXU=
X-Google-Smtp-Source: APXvYqyUL/7XSwfJYR3ilAkd+OfYZXkjxiqwGkNg6FSy5TzKmMfLNWOPtybtiTeMJqLuCJ2cXClRDA==
X-Received: by 2002:ad4:4673:: with SMTP id z19mr25933996qvv.236.1571150255607;
        Tue, 15 Oct 2019 07:37:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2a53])
        by smtp.gmail.com with ESMTPSA id x55sm12586667qta.74.2019.10.15.07.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 07:37:34 -0700 (PDT)
Date:   Tue, 15 Oct 2019 07:37:31 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>, mm <linux-mm@kvack.org>,
        fsdev <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC] writeback: add elastic bdi in cgwb bdp
Message-ID: <20191015143731.GJ18794@devbig004.ftw2.facebook.com>
References: <20191012132740.12968-1-hdanton@sina.com>
 <20191015140356.9256-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015140356.9256-1-hdanton@sina.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Hillf.

Do you have a test case which can demonstrate the problem you're
seeing in the existing code?

Thanks.

-- 
tejun
