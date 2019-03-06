Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64101C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="cLak+fkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfCFNG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:06:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfCFNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:06:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id 125so8148688pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lYFisdL+emxX/yjhRwvfei8UQc72RGGLjL/HzcIurDc=;
        b=cLak+fkRb0O9N36cRBXR0tIORoqVJxZ7ho2DOkLt9kahJGvAC87zHhp1EhS+FaCI6N
         64Nca7nkQJmc8Ta4Xu5NycVUDhC+r0AdMVUYL3w+51kWq9QtPbdBEF2WaGRHDv03lA3V
         0/b/Rf4n74LhnFC3Kksz+CwFlyn5hivfSwNhTuzAZU7m6SVWyix3v7rS4wyqjjZOlQuX
         zX1kyt/LbnnJgOYR9xb2o+9l5g/v3e371TkOhKxTCH3gTa3ftEUk55v9oRM+IqBC2dUn
         i9j2ihAYu03W9iivIo1u4bpyt44/sSHgVPZS+Sg9DcAbppyJSuoiEyGosF4XIvC4e9Zr
         KhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lYFisdL+emxX/yjhRwvfei8UQc72RGGLjL/HzcIurDc=;
        b=kWjiBDp1CaU6s5UfpJb38Sl2xanGmJHgFL68Fwzb8p2M8t4fRMWselss9LAqgz5d5C
         5i9hOpTxpnlMnwFxsyHQyfyZeGVNNYsd1tmj2wDlU8RZWiMavzCs7p5HNQ3XthQTa1pl
         LGMalqRGokEOcsOLGtZxTMeeeunxGTtDOg4dKGXRdVEr68EuYv/NmeIV6MYHikh01oJJ
         qrCC222skd4rI5GSp6OLYM05NDn/LRdWr4eQfFJqIuE198m+a4nm+SE8BxdwKzyX8lmW
         jX+sTYiuRkqmB4uLwTJ6L8+d6BT2H17z3mlDJNGwDcCBkoHqYKp6TYTWaJFIjHz9u0Dv
         tFiQ==
X-Gm-Message-State: APjAAAWD8qeFvWhtqZKQWcpbkQ0c/Sc0pYsaa/W17A3FmccMe/LQZ4MI
        sacV3ODoQf6b9dtr65Ed3CbQgw==
X-Google-Smtp-Source: APXvYqzAzhlyQEbt3pF4RlErlixy++ggRJiOcUf8oHOCw2kVjZAxkP62zfdXeK2RBjhWPna+/sKHbg==
X-Received: by 2002:a62:4553:: with SMTP id s80mr7069624pfa.141.1551877586275;
        Wed, 06 Mar 2019 05:06:26 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id h10sm3128992pfo.128.2019.03.06.05.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 05:06:25 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 98357301186; Wed,  6 Mar 2019 16:06:21 +0300 (+03)
Date:   Wed, 6 Mar 2019 16:06:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Oliver <oohall@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
Message-ID: <20190306130621.qrwybv5dpv3bzyym@kshutemo-mobl1>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
 <20190306124453.126d36d8@naga.suse.cz>
 <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 06:15:25PM +0530, Aneesh Kumar K.V wrote:
> On 3/6/19 5:14 PM, Michal Suchánek wrote:
> > On Wed, 06 Mar 2019 14:47:33 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > > Dan Williams <dan.j.williams@intel.com> writes:
> > > 
> > > > On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> > > > > 
> > > > > On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > Also even if the user decided to not use THP, by
> > > echo "never" > transparent_hugepage/enabled , we should continue to map
> > > dax fault using huge page on platforms that can support huge pages.
> > 
> > Is this a good idea?
> > 
> > This knob is there for a reason. In some situations having huge pages
> > can severely impact performance of the system (due to host-guest
> > interaction or whatever) and the ability to really turn off all THP
> > would be important in those cases, right?
> > 
> 
> My understanding was that is not true for dax pages? These are not regular
> memory that got allocated. They are allocated out of /dev/dax/ or
> /dev/pmem*. Do we have a reason not to use hugepages for mapping pages in
> that case?

Yes. Like when you don't want dax to compete for TLB with mission-critical
application (which uses hugetlb for instance).

-- 
 Kirill A. Shutemov
