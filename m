Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC71C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C044E2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfDOLoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:44:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDOLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:44:16 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLAZe-1hY4q10n22-00IFgj; Mon, 15 Apr 2019 13:43:39 +0200
Subject: Re: [RFC PATCH 1/5] efi: Detect UEFI 2.8 Special Purpose Memory
To:     Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491334.3190322.44013027330479237.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ocQGxTAapfjb5WufhL=Qj54LythHcPHsyy+wUnVBnfA@mail.gmail.com>
 <CAPcyv4gUL8j+EaAZ556_NKXLgva++HgPBOeeAUNHN+DAWaewaQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <766281c0-e770-2a0f-e885-0921e599740f@metux.net>
Date:   Mon, 15 Apr 2019 13:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gUL8j+EaAZ556_NKXLgva++HgPBOeeAUNHN+DAWaewaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NJ9bcWM7yqVwBf1LcyXAdmYG8vFaS080HOQiIrzAqQ2l0P8+xiK
 YHi6epj0RyIlsPo+9vhCXVypMA9NI8N6znSt43KjG6fJZNVLIcWMAk/xqlKSKirJS7LBegS
 HZD2Re5tdTf+bInVvfP7vdiI9NklOQsbu6BKL958fq6Ka1kJCX6VdBz/wf1fencXTzYdHLG
 Q44u55PW30p62rg1gwSxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5T+WGcN6N7c=:1snJlLAJ6sSqyTgFTssxqs
 OxoIDpBRG0z6TOs75ab9uMrxzT4w7mCp7jwFyyRNLMJYCl5TgiRbcxM8Y/RTL4xfoo2UZ2Fxi
 W/hc9Ow3qE8qxC5/dUgLOf9dqkfHorvhqwQyqMQFXCor1u1tHSOZW7+O2Vg3K8bSHkMqI/pDd
 Wxs7PvxTwf01pIQFU93jl6us5S6ZVDtDLgs9JgjxwU9HQ+il5Ztalb0pyZ4XSlvYrkifWXBT2
 y3CcxcOMzL4PlSdHH40hJ8InFF7RlOU1vXndFC240zOr6Cxz21H9KM6l6XzZDLgIaTxayQo5m
 AJ+Hz2XjXBdRShBYLTXlmso7y+CpffXGMV8GRPamBlk/scFN4kd6ERgFRyFTmqOPl/uwhMIvp
 uaLgBkA10QqgksdJfX/Vg82X7qVcmcquK0e9MbO5XoR0rFCaidzicD42qAPLgV/hZ/tbMBaK7
 6nuJpuKtoFnFBgGrSUZAdG1ogQNx96NNJLldd1VYbFLkD4yCVyrecne1dBeZ5/Af9AFV1yNgn
 MzOtD4e3FB7VqNmN9h4ORCzBh3CcHrNv8n1Hfkh46FRip0tB2a3XG4H0bUxyi3q6VYH5G7GiA
 Qd8Xldk6yHGKuyTnMBRcPzp4y31VvjLesY74W6Zs3aJ8Ys+Mg332ELC3oxUf8+TtzBHv5qMLb
 WBfHGdSDyep/EzVRB25HU2rg6I+sWfBnBxyKXJvCBM9ucBFMKqOSf97zjXevVycNGuJPpgMzW
 6iiKpAe65dYxSz3J3E3MVDpMFyxE5nnQsvfO5eWigzXm3/fucU9I5VTMWkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.19 18:43, Dan Williams wrote:

>>> UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
>>> interpretation of the EFI Memory Types as "reserved for a special
>>> purpose".

What exactly is that suppose to mean ?
Little pacmans might come around and eat the bits ? :o
Who writes specs like that ? What drugs do did take ?


I vote for calling this the lore-ipsum-area ;-)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
