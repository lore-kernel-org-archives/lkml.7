Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D16A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfC0NDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:03:32 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44755 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728315AbfC0NDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:03:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmZ5w-_1553691746;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmZ5w-_1553691746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 24/42] docs/zh_CN: add submit-checklist file
Date:   Wed, 27 Mar 2019 21:01:30 +0800
Message-Id: <20190327130148.3258-25-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
References: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it appears in 'make htmldocs' in Chinese version.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/process/submit-checklist.rst        | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/submit-checklist.rst

diff --git a/Documentation/translations/zh_CN/process/submit-checklist.rst b/Documentation/translations/zh_CN/process/submit-checklist.rst
new file mode 100644
index 000000000000..012f2bf88a35
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
@@ -0,0 +1,102 @@
+.. _cn_submitchecklist:
+
+Linux内核补丁提交清单
+~~~~~~~~~~~~~~~~~~~~~
+
+如果开发人员希望看到他们的内核补丁提交更快地被接受，那么他们应该做一些基本
+的事情。
+
+这些都是在
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+和其他有关提交Linux内核补丁的文档中提供的。
+
+1) 如果使用工具，则包括定义/声明该工具的文件。不要依赖于其他头文件拉入您使用
+   的头文件。
+
+2) 干净的编译：
+
+   a) 使用适用或修改的 ``CONFIG`` 选项 ``=y``、``=m`` 和 ``=n`` 。没有GCC
+      警告/错误，没有链接器警告/错误。
+
+   b) 通过allnoconfig、allmodconfig
+
+   c) 使用 ``O=builddir`` 时可以成功编译
+
+3) 通过使用本地交叉编译工具或其他一些构建场在多个CPU体系结构上构建。
+
+4) PPC64是一种很好的交叉编译检查体系结构，因为它倾向于对64位的数使用无符号
+   长整型。
+
+5) 如下所述 :ref:`Documentation/process/coding-style.rst <codingstyle>`.
+   检查您的补丁是否为常规样式。在提交（ ``scripts/check patch.pl`` ）之前，
+   使用补丁样式检查器检查是否有轻微的冲突。您应该能够处理您的补丁中存在的所有
+   违规行为。
+
+6) 任何新的或修改过的 ``CONFIG`` 选项都不会弄脏配置菜单，并默认为关闭，除非
+   它们符合 ``Documentation/kbuild/kconfig-language.txt`` 中记录的异常条件,
+   菜单属性：默认值.
+
+7) 所有新的 ``kconfig`` 选项都有帮助文本。
+
+8) 已仔细审查了相关的 ``Kconfig`` 组合。这很难用测试来纠正——脑力在这里是有
+   回报的。
+
+9) 用 sparse 检查干净。
+
+10) 使用 ``make checkstack`` 和 ``make namespacecheck`` 并修复他们发现的任何
+    问题。
+
+    .. note::
+
+        ``checkstack`` 并没有明确指出问题，但是任何一个在堆栈上使用超过512
+        字节的函数都可以进行更改。
+
+11) 包括 :ref:`kernel-doc <kernel_doc>` 内核文档以记录全局内核API。（静态函数
+    不需要，但也可以。）使用 ``make htmldocs`` 或 ``make pdfdocs`` 检查
+    :ref:`kernel-doc <kernel_doc>` 并修复任何问题。
+
+12) 通过以下选项同时启用的测试 ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
+    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
+    ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD``
+
+13) 已经过构建和运行时测试，包括有或没有 ``CONFIG_SMP``, ``CONFIG_PREEMPT``.
+
+14) 如果补丁程序影响IO/磁盘等：使用或不使用 ``CONFIG_LBDAF`` 进行测试。
+
+15) 所有代码路径都已在启用所有lockdep功能的情况下运行。
+
+16) 所有新的/proc条目都记录在 ``Documentation/``
+
+17) 所有新的内核引导参数都记录在
+    Documentation/admin-guide/kernel-parameters.rst 中。
+
+18) 所有新的模块参数都记录在 ``MODULE_PARM_DESC()``
+
+19) 所有新的用户空间接口都记录在 ``Documentation/ABI/`` 中。有关详细信息，
+    请参阅 ``Documentation/ABI/README`` 。更改用户空间接口的补丁应该抄送
+    linux-api@vger.kernel.org。
+
+20) 检查是否全部通过 ``make headers_check`` 。
+
+21) 已通过至少注入slab和page分配失败进行检查。请参阅 ``Documentation/fault-injection/``
+    如果新代码是实质性的，那么添加子系统特定的故障注入可能是合适的。
+
+22) 新添加的代码已经用 ``gcc -W`` 编译（使用 ``make EXTRA-CFLAGS=-W`` ）。这
+    将产生大量噪声，但对于查找诸如“警告：有符号和无符号之间的比较”之类的错误
+    很有用。
+
+23) 在它被合并到-mm补丁集中之后进行测试，以确保它仍然与所有其他排队的补丁以
+    及VM、VFS和其他子系统中的各种更改一起工作。
+
+24) 所有内存屏障例如 ``barrier()``, ``rmb()``, ``wmb()`` 都需要源代码中的注
+    释来解释它们正在执行的操作及其原因的逻辑。
+
+25) 如果补丁添加了任何ioctl，那么也要更新 ``Documentation/ioctl/ioctl-number.txt``
+
+26) 如果修改后的源代码依赖或使用与以下 ``Kconfig`` 符号相关的任何内核API或
+    功能，则在禁用相关 ``Kconfig`` 符号和/或 ``=m`` （如果该选项可用）的情况
+    下测试以下多个构建[并非所有这些都同时存在，只是它们的各种/随机组合]：
+
+    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``, ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
+    ``CONFIG_NET``, ``CONFIG_INET=n`` (但是后者伴随 ``CONFIG_NET=y``).
-- 
2.19.1.856.g8858448bb

