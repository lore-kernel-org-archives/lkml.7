Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D651DC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C6A20872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="u/3he9Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfIZKXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:23:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42345 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfIZKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:23:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so1457228ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nVK/nJtOcV+sZhmR12a3Q1eiclcyZVkWGk+yvC3nOQ=;
        b=u/3he9EefTJa3RjrVyPZ2G2QCe6PmWaeWyzhIveVMIZtZtAO5bBrHnDfG2cBvW0ZrX
         9ss9GzL1jj9vFbjiYEIsUPhnoKQ7MA/ZqAgsHgwgrl9Ahz1OTd65OJUPGBOb3CdI/tpT
         DjjtFnGk+MliapAVoTVrwWZZq5kVjrTAf+9IyVPpXuCFhsIK8d9qlWAGRdrOGMI2VBk1
         mJh7IzSatm3XKDxGxrpVEf/tj1uJDEvFtO5OndhbLCxcNFfXCRcGWNe48WwZjHgmMi6I
         tHBFtY8lV+tDJhmCFSwIP15z5L04WersVH4ML/DcTZu7848qnMSxJ54WhBaOTt24Dywv
         n0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nVK/nJtOcV+sZhmR12a3Q1eiclcyZVkWGk+yvC3nOQ=;
        b=Pmu7t9gOrc4iKyBS6gmZLG4f5jph6gy3e7vjvTjWT81ypTX5NEHBIsbUQYfzd4Yeq0
         xzv2+/2HWpMpKKsd925c8U/67KY58JQWonb0jW+EXK7cw95cyOyUD5bsaKCu6day9Z36
         U9i8OxckvGPKc/jt/c2Qm/AmJlib2z+z6cd4NTf9xzMmWmkX2lTlSvvM41M9G8HbCP+D
         vKgOeStPu2TUhXSRpJjbWheltqy6UXF8hCsDWeMr/LzoMKA0ma2JUu7CYw49px14O8Wt
         KJ9ymkNvC02um9VOMG2GlbrWuaflB7eoLPm9j7WVAzkMAd/MLrXeKgkTFRWBlVpoqfKm
         Xlaw==
X-Gm-Message-State: APjAAAUJ4q9qili4BjMZN25LLbJMIRRcQMLgj90lBc6mpuR/Khp/v46p
        WMMSIBtpa2OoZ6cuS/zqGOhpyg==
X-Google-Smtp-Source: APXvYqxqSbxOcExsIqaMDT4Qk3/4chkCM7iICimZba8auPxPatB84xL4JNs81Aqc0zPrAs6Gw8a4dw==
X-Received: by 2002:a17:906:6848:: with SMTP id a8mr2413780ejs.104.1569493416937;
        Thu, 26 Sep 2019 03:23:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e44sm384559ede.34.2019.09.26.03.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 03:23:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2CFF31004E0; Thu, 26 Sep 2019 13:23:39 +0300 (+03)
Date:   Thu, 26 Sep 2019 13:23:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH v3 2/2] x86/boot/64: round memory hole size up to next
 PMD page.
Message-ID: <20190926102339.owzlugs6sro6rodn@box>
References: <cover.1569358538.git.steve.wahl@hpe.com>
 <df4f49f05c0c27f108234eb93db5c613d09ea62e.1569358539.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4f49f05c0c27f108234eb93db5c613d09ea62e.1569358539.git.steve.wahl@hpe.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 04:04:31PM -0500, Steve Wahl wrote:
> The kernel image map is created using PMD pages, which can include
> some extra space beyond what's actually needed.  Round the size of the
> memory hole we search for up to the next PMD boundary, to be certain
> all of the space to be mapped is usable RAM and includes no reserved
> areas.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Cc: stable@vger.kernel.org

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
