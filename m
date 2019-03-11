Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0385AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B867920657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCKLsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:48:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfCKLr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:47:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ED20CA4C898C32F3FBC6;
        Mon, 11 Mar 2019 19:47:55 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 19:47:47 +0800
Date:   Mon, 11 Mar 2019 11:47:37 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCHv7 00/10] Heterogenous memory node attributes
Message-ID: <20190311114459.00006f3d@huawei.com>
In-Reply-To: <20190227225038.20438-1-keith.busch@intel.com>
References: <20190227225038.20438-1-keith.busch@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 15:50:28 -0700
Keith Busch <keith.busch@intel.com> wrote:

> == Changes since v6 ==
> 
>   Updated to linux-next, which has a change to the HMAT structures to
>   account for ACPI revision 6.3.
> 
>   Changed memory-side cache "associativity" attribute to "indexing"
> 
> 
> Regarding the Kconfig, I am having the implementation specific as a user
> selectable option, and the generic interface, HMEM_REPORTING, is not a
> user prompt. I just wanted to clarify the point that there's only one.
> 
> 
> == Background ==
> 
> Platforms may provide multiple types of cpu attached system memory. The
> memory ranges for each type may have different characteristics that
> applications may wish to know about when considering what node they want
> their memory allocated from. 
> 
> It had previously been difficult to describe these setups as memory
> rangers were generally lumped into the NUMA node of the CPUs. New
> platform attributes have been created and in use today that describe
> the more complex memory hierarchies that can be created.
> 
> This series' objective is to provide the attributes from such systems
> that are useful for applications to know about, and readily usable with
> existing tools and libraries. Those applications may query performance
> attributes relative to a particular CPU they're running on in order to
> make more informed choices for where they want to allocate hot and cold
> data. This works with mbind() or the numactl library.

Hi Keith,

Great to see this 'nearly' good to go.

For those that were too small / trivial to deserve a reviewed-by
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Subject to that one tweak in patch 7,
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note that my tests were very limited for the memory-side caches
and not exactly comprehensive for the access attributes either.

They focused on the cases I care about rather than putting together
a fuller test suite.  That is probably worth doing at some point though
not sure I'll get to it any time soon.

Thanks,

Jonathan

> 
> Keith Busch (10):
>   acpi: Create subtable parsing infrastructure
>   acpi: Add HMAT to generic parsing tables
>   acpi/hmat: Parse and report heterogeneous memory
>   node: Link memory nodes to their compute nodes
>   node: Add heterogenous memory access attributes
>   node: Add memory-side caching attributes
>   acpi/hmat: Register processor domain to its memory
>   acpi/hmat: Register performance attributes
>   acpi/hmat: Register memory side cache attributes
>   doc/mm: New documentation for memory performance
> 
>  Documentation/ABI/stable/sysfs-devices-node   |  87 +++-
>  Documentation/admin-guide/mm/numaperf.rst     | 164 +++++++
>  arch/arm64/kernel/acpi_numa.c                 |   2 +-
>  arch/arm64/kernel/smp.c                       |   4 +-
>  arch/ia64/kernel/acpi.c                       |  14 +-
>  arch/x86/kernel/acpi/boot.c                   |  36 +-
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/hmat/Kconfig                     |  11 +
>  drivers/acpi/hmat/Makefile                    |   1 +
>  drivers/acpi/hmat/hmat.c                      | 670 ++++++++++++++++++++++++++
>  drivers/acpi/numa.c                           |  16 +-
>  drivers/acpi/scan.c                           |   4 +-
>  drivers/acpi/tables.c                         |  76 ++-
>  drivers/base/Kconfig                          |   8 +
>  drivers/base/node.c                           | 352 +++++++++++++-
>  drivers/irqchip/irq-gic-v2m.c                 |   2 +-
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   2 +-
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |   2 +-
>  drivers/irqchip/irq-gic-v3-its.c              |   6 +-
>  drivers/irqchip/irq-gic-v3.c                  |  10 +-
>  drivers/irqchip/irq-gic.c                     |   4 +-
>  drivers/mailbox/pcc.c                         |   2 +-
>  include/linux/acpi.h                          |   6 +-
>  include/linux/node.h                          |  72 ++-
>  25 files changed, 1487 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/numaperf.rst
>  create mode 100644 drivers/acpi/hmat/Kconfig
>  create mode 100644 drivers/acpi/hmat/Makefile
>  create mode 100644 drivers/acpi/hmat/hmat.c
> 


