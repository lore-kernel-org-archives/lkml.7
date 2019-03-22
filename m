Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FBEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E18A218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7TjPlkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCVBqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:46:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39754 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:46:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so595363otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5Low4SuSzWr6ujbDyxHrARXjGVys0Q5FQRetssJ/yY=;
        b=T7TjPlkJIXF7J9SZ+bV1+gtfPYv4ahYUwC0C7UfS+kQHoq0koldlw5i82ZgzJzKmih
         76beQhdFRHnJE5OWJWYyP0kiR5MzzW8sDkKL06X/b9iy2DNLPF5gY8izh3FQY/oiBP/V
         HhVSlZQF+z3K5McQKdSAvvb5eQdWR1VuqrapcS5h1nvNa/Retg50SMYxY3UlwfmI1rTH
         LRN+K0+gshCBFW/bYaCFwZFNjU8WStUIdpU1nF1vQN2Mq6+G0EP+TasUXYko1gTcz27F
         r9v70by+4ETaDxNNU6B5nVPr7YtkItNXAnBpTYrTMTV2QXcBUxeuJIzJq/eN4JHkTHXX
         WiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5Low4SuSzWr6ujbDyxHrARXjGVys0Q5FQRetssJ/yY=;
        b=rHC/mBg76yS43iSBrA2LZHdTSzwmbamHQ/jmzM9hM7bsZ9Fz62MWq7LWcW1hCLVDN9
         dYWJ6m5EhQfyNvOnhKfuIEh0hPAIdwn2IyZ5w8Ki3tFwthKhnoGSkrO2ExaWA3fQgns0
         sM3Ou+kRrIkEWfmyE9oZj2kWlMcZxVCOALHAge+xGsSXO/E5HAC7eef0LPzFowEgH1JJ
         Zi202Ymp7/zyxJh3Zp9cDeBcPoWa+NCTY7SlT3ityN01+XQDIElmcI1bo5PDI62PBOqh
         nor+2i7DpWwoZumUENz4f9maN57YhTT+WF+h1POioMdpx1hbI8W18yrkkXfXJGTU8ut7
         Q0Hg==
X-Gm-Message-State: APjAAAVRlMI/Qjlb/lyuqDlPg4UmPbJ1F+sszpvyJmz8ih1FHCYbFFNH
        JRyTsYCA15xsAxywDBQxiocGBGBaT6FlMh7V0xjDNw==
X-Google-Smtp-Source: APXvYqy/8dG61BYN/fnVjVtu8UVSnJ5MzUoCEbyHB5UgFgPA66o4CcZ22P7g4ceO4cAryYGdlGcIT448OTQSNXOJlqI=
X-Received: by 2002:a9d:d66:: with SMTP id 93mr4885898oti.25.1553219167991;
 Thu, 21 Mar 2019 18:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-18-brendanhiggins@google.com> <09b06e6d-fd36-707e-cb7a-e935bd930510@gmail.com>
In-Reply-To: <09b06e6d-fd36-707e-cb7a-e935bd930510@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 18:45:56 -0700
Message-ID: <CAFd5g47wgUT-+NJEaZYROKGQ1YuroSv0v4Yj6=Ji6h6VANp0dg@mail.gmail.com>
Subject: Re: [RFC v4 17/17] of: unittest: split up some super large test cases
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> > Split up the super large test cases of_unittest_find_node_by_name and
> > of_unittest_dynamic into properly sized and defined test cases.
>
> I also still object to this patch.

I figured. Will drop.
